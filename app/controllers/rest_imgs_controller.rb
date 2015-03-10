class RestImgsController < ApplicationController

	def create
		@new = RestImg.new(rest_imgs_params)
		if @new.save
			flash[:success] = "음식점 사진이 저장되었습니다!"
			redirect_to :back
		else
			flash[:danger] = "적어도 하나의 사진을 저장해야합니다."
			redirect_to :back
		end
	end

	def destroy
	end

	def parse_rest_imgs
		@restaurant = Restaurant.find(params[:id])
		@rest_imgs = @restaurant.rest_imgs
		latlng = google_maps_geocode(params[:addr])
		@venue_id = foursquare_venue_id(latlng[:lat], latlng[:lng], params[:name])
		@image_url = foursquare_image_parse(@venue_id) if !@venue_id.nil?

		respond_to do |format|
			format.js
		end
	end

	private
		def rest_imgs_params
			params.require(:rest_img).permit(:restaurant_id, :img)
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
end
