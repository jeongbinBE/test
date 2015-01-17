class RestaurantsController < ApplicationController

  def index
		name = params[:name]
		addr = params[:addr]
		@restaurants = Restaurant.joins(:rest_key).where("rest_keys.name like ? AND
																											rest_keys.addr like ?",
																										 "%#{name}%",
																										 "%#{addr}%")
  end

  def show
  end
end
