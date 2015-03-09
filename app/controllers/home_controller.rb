class HomeController < ApplicationController
	include ActionView::Helpers::NumberHelper

	require 'nokogiri'
	require 'uri'
	require 'open-uri'

  def index
		@restaurants_count = Restaurant.all.count
		@restaurants_registered = Restaurant.where("menu_on > 0 ").count
		@menus_count = Menu.all.count
		# for meta description
		@page_description = "메뉴맵은 온라인 메뉴제공 서비스로서 편리하고 객관적인 음식점, 맛집 검색 엔진입니다. 현재 서울시내 #{number_with_delimiter(Restaurant.count, delimiter: ',')}개 음식점의 음식분류, 주소, 전화번호, 배달여부와 #{number_with_delimiter(Menu.count, delimiter: ',')}여개의 메뉴정보를 갖고 있으며, 소비자들이 직접 음식점 정보를 저장할 수 있습니다."
  end

  def manual
		# instruction for search
		@cat = Category.all
		@sub = SubCategory.all

		# instruction for posts
		@restaurants = Restaurant
									 	 .where("id = ? OR id = ? OR id = ?", 
															 1000000, 1099572, 1120855)
		@restaurant = Restaurant.find(1000000)
		@titles = @restaurant.menu_titles
		@menus  = @restaurant.menus
  end

  def search
		@cat = Category.all
		@sub = SubCategory.all

		if params[:term]
			@autocomplete = Autocomplete
												.where("name LIKE ?", "%#{params[:term]}%")
												.limit(10)
		end

		respond_to do |format|
			format.html
			format.json { render :json => @autocomplete.to_json }
		end
  end

	def update_sub_categories
		@sub = SubCategory.where("category_id = ?", params[:category_id])
		respond_to do |format|
			format.js
		end
	end

	def test
		@restaurant = Restaurant.find(1014823)
		@test = google_maps_geocode(@restaurant.addr)
		@test2 = foursquare_venue_id(@test[:lat], @test[:lng], "맥도날드")
		@image_url = foursquare_image_parse(@test2) if !@test2.nil?
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
		
end
