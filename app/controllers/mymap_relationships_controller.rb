class MymapRelationshipsController < ApplicationController
	
	before_action :logged_in_user?

	def create
		@restaurant = Restaurant.find(params[:mymap_rest_id])
		current_user.mymap_on(@restaurant)
		respond_to do |format|
			format.html { redirect_to @restaurant }
			format.js
		end
	end

	def destroy
		@restaurant = MymapRelationship.find(params[:id]).mymap_rest
		current_user.mymap_off(@restaurant)
		respond_to do |format|
			format.html { redirect_to @restaurant }
			format.js
		end
	end
end
