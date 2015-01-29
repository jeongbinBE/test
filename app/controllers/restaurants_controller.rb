class RestaurantsController < ApplicationController
	
	include RestaurantsHelper

  def index
		@search_name = params[:name]
		@search_addr = params[:addr]
		@search_cat = Category.find_by(id: params[:category]).name
		@search_sub_cat  = params[:sub_category]
		@search_delivery = params[:delivery]

		# search algorithm
		@restaurants = Restaurant.joins(:rest_key).merge(RestKey.search(@search_delivery, @search_sub_cat, @search_name, @search_addr)).paginate(:page => params[:page]).order('menu_on DESC')

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

		# for title
		@page_title = @restaurant.rest_info.title_addr + " " + @restaurant.name
		@page_title += "(" + @restaurant.sub_cat
		@page_title += " 배달가능" if @restaurant.delivery
		@page_title += ") || MenuMap"
  end

	def update
		@restaurant = Restaurant.find(params[:id])
		if @restaurant.update_attributes(restaurant_params)
			flash[:success] = "업소 사진을 저장했습니다."
			redirect_to @restaurant
		else
			flash[:error] = "사진 저장에 실패했습니다."
			redirect_to @restaurant
		end
	end

	private
		
		def restaurant_params
			params.require(:restaurant).permit(:picture)
		end
end
