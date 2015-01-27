class RestaurantsController < ApplicationController
	
	include RestaurantsHelper

  def index
		@search_name = params[:name]
		@search_addr = params[:addr]
		@search_cat = Category.find_by(id: params[:category]).name
		@search_sub_cat  = params[:sub_category]
		@search_delivery = params[:delivery]

		@restaurants = Restaurant.joins(:rest_key).merge(RestKey.search(@search_delivery, @search_sub_cat, @search_name, @search_addr)).paginate(:page => params[:page]).order('menu_on DESC')
  end

  def show
		@restaurant = Restaurant.find(params[:id])
		@titles = @restaurant.menu_titles
		@menus = @restaurant.menus
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
