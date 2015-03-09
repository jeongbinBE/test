class RestaurantsController < ApplicationController
	include RestaurantsHelper

	# blog parsing
	require 'nokogiri'
	require 'uri'
	require 'open-uri'


  def index
		@search_name = params[:name]
		@search_addr = params[:addr]
		@search_cat = Category.find_by(id: params[:category]).name
		@search_sub_cat  = params[:sub_category]
		@search_delivery = params[:delivery]

		# search algorithm
		@restaurants = Restaurant.joins(:rest_key).merge(RestKey.search(@search_delivery, @search_sub_cat, @search_name, @search_addr)).paginate(:page => params[:page])

		# for title
		@page_title = "#{ @search_addr + "주변 " unless @search_addr.empty?}"
		if @search_name.empty?
			@page_title += @search_sub_cat 
		else
			@page_title += "#{@search_name}(#{@search_sub_cat})"	 		
		end
		@page_title += " 배달가능업소" if @search_delivery
		@page_title += " 검색결과 || MenuMap"
  end

  def show
		@restaurant = Restaurant.find(params[:id])
		@titles = @restaurant.menu_titles
		@menus = @restaurant.menus
		@menu = Menu.new
		@comments = @restaurant.comments
		@comment = Comment.new

		# restaurant images
		@rest_imgs = @restaurant.rest_imgs # for carousel
		@rest_img = RestImg.new						 # for image uploads

		# blog results
		query = @restaurant.rest_info.title_addr + " " + @restaurant.name
		query = URI.encode("#{query}")

		naver_key = "key=813b2e5e653326da6ff7d7114acf8748"
		naver_options = "&query=#{query}&display=5&target=blog&sort=sim" 
		naver_url = "http://openapi.naver.com/search?#{naver_key}#{naver_options}"
																				 
		items = Nokogiri::XML(open(naver_url)).xpath("//item")
		
		@naver_blogs = []
		items.each do |item|
			temp = Hash.new
			temp[:title] = item.xpath("title").text 
			temp[:link]  = item.xpath("link").text
			temp[:description]  = item.xpath("description").text
			temp[:blogger_name] = item.xpath("bloggername").text
			temp[:blogger_link] = item.xpath("bloggerlink").text
			@naver_blogs << temp
		end

		daum_key = "?apikey=61a98e1ad6ddb530bcb93294019b80b8" 
		daum_options = "&q=#{query}&output=xml&result=5&sort=accu&advance=n" 
		daum_url = "http://apis.daum.net/search/blog#{daum_key}#{daum_options}"
																				 
		items = Nokogiri::XML(open(daum_url)).xpath("//item")
		
		@daum_blogs = []
		items.each do |item|
			temp = Hash.new
			temp[:title] = item.xpath("title").text 
			temp[:link]  = item.xpath("link").text
			temp[:description]  = item.xpath("description").text
			temp[:blogger_name] = item.xpath("author").text
			temp[:blogger_link] = item.xpath("comment").text
			@daum_blogs << temp
		end

		# restaurant information error
		@report_rest_err = ReportRestErr.new

		# for title
		@page_title = @restaurant.name + "(" + @restaurant.sub_cat + ") - "
		@page_title += @restaurant.rest_info.title_addr
		@page_title += " 배달가능" if @restaurant.delivery
		@page_title += " || MenuMap 온라인 메뉴제공 서비스"

		# for description
		title_addr = @restaurant.rest_info.title_addr
		title_menu = []
		@menus.take(5).each do |menu|
			title_menu << menu.menu_name.to_s + menu.menu_side_info.to_s
		end
		title_menu = title_menu.join(", ")
		
		@page_description = "#{title_addr}지역에 위치한 #{"배달가능" if @restaurant.delivery} 음식점 #{@restaurant.name}(#{@restaurant.cat}, #{@restaurant.sub_cat})은 #{title_menu} 메뉴를 제공하고 있습니다. 주소는 #{@restaurant.addr}#{", 전화번호는 " if @restaurant.phnum}#{@restaurant.phnum if @restaurant.phnum}입니다."

		# Foursquare API photos
		@test = google_maps_geocode(@restaurant.addr)
		@test2 = foursquare_venue_id(@test[:lat], @test[:lng], @restaurant.name)
		@image_url = foursquare_image_parse(@test2) if !@test2.nil?
  end

	def update
		@restaurant = Restaurant.find(params[:id])
		@restaurant.rest_imgs.create(img: params[:restaurant][:picture])
		if @restaurant.update_attributes(restaurant_picture_params)
			flash[:success] = "업소 사진을 저장했습니다."
			redirect_to @restaurant
		else
			flash[:danger] = "사진 저장에 실패했습니다."
			redirect_to @restaurant
		end
	end

	private
		def google_maps_geocode(addr)
			addr = URI.encode("#{addr}")
			parameter = "address=#{addr}&sensor=false"
			url = "http://maps.googleapis.com/maps/api/geocode/json?#{parameter}"
			
			latlng = Hash.new
			temp = JSON.load(open(url))["results"][0]["geometry"]["location"]
			latlng[:lat] = temp["lat"]
			latlng[:lng] = temp["lng"]
			return latlng
		end

		def foursquare_venue_id(lat, lng, name)
			latlng = "ll=#{lat},#{lng}"
			name = URI.encode(name)
			other_params = "query=#{name}&intent=match&v=20150309&m=foursquare" 

			url  = "https://api.foursquare.com/v2/venues/search"
			url  = foursquare_add_client_credentials(url)
			url += "&#{latlng}&#{other_params}"
			
			foursquare_json = JSON.load(open(url))

			if foursquare_json["meta"]["code"] == 200 &&
				 !foursquare_json["response"]["venues"][0].nil?
				foursquare_json["response"]["venues"][0]["id"]
			else
				return nil
			end
		end

		def foursquare_image_parse(venue_id)
			url = "https://api.foursquare.com/v2/venues/#{venue_id}/photos"
			url = foursquare_add_client_credentials(url)
			url += "&limit=10&v=20150309&m=foursquare"
			
			images = []
			JSON.load(open(url))["response"]["photos"]["items"].each do |item|
				image_url = item["prefix"] + "700x700" + item["suffix"]
				images << image_url
			end
			return images
		end

		# foursquare API's client_id, client_secret
		def foursquare_add_client_credentials(url)
			url += "?client_id=JHL4AYTWC3NVEWA2LXA35NBYRYQIJCBZDOIRFAQISM4DUJRH"
			url += "&client_secret=APFUDIQRTSEFAOM5F13RHUGH3BI3Q3PKB3PY1KVQMWPID55D"
		end

		def restaurant_picture_params
			params.require(:restaurant).permit(:picture)
		end
end
