class RestaurantsController < ApplicationController
	
	include RestaurantsHelper

  def index
		@search_name = params[:name]
		@search_addr = params[:addr]
		@search_cat  = params[:sub_category]
		@search_deliver = params[:delivery]

		name = @search_name.downcase.split
		addr = @search_addr.split
		cat_code = find_category(@search_cat)
		@restaurants = Restaurant.joins(:rest_key).where("rest_keys.name LIKE ? AND
																											rest_keys.name LIKE ? AND
																											rest_keys.name LIKE ? AND
																											rest_keys.addr LIKE ? AND
																											rest_keys.addr LIKE ? AND
																											rest_keys.addr LIKE ? AND
																											rest_keys.addr LIKE ? AND
																											rest_keys.addr LIKE ? AND
																											rest_keys.cat_code >= ? AND
																											rest_keys.cat_code < ?",
																										 "%#{name[0]}%",
																										 "%#{name[1]}%",
																										 "%#{name[2]}%",
																										 "%#{addr[0]}%",
																										 "%#{addr[1]}%",
																										 "%#{addr[2]}%",
																										 "%#{addr[3]}%",
																										 "%#{addr[4]}%",
																										 cat_code[0], 
																										 cat_code[1])
  end

  def show
  end

end
