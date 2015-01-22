class RestaurantsController < ApplicationController
	
	include RestaurantsHelper

  def index
		@search_name = params[:name]
		@search_addr = params[:addr]
		@search_cat  = params[:sub_category]
		@search_deliver = params[:delivery]

		@restaurants = Restaurant.joins(:rest_key).merge(RestKey.search(@search_deliver, @search_cat, @search_name, @search_addr)).paginate(:page => params[:page])
  end

  def show
		@restaurant = Restaurant.find(params[:id])
		@titles = @restaurant.menu_titles
		@menus = @restaurant.menus
  end

end
