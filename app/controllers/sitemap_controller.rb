class SitemapController < ApplicationController
	layout nil

  def show
		@static = "http://menumap.co.kr/"
		@restaurants = Restaurant.where("picture is not null OR menu_on > 0 OR delivery is true OR updated_at > ?", Time.now - 7.day)
		respond_to do |format|
			format.xml 
		end
  end
end
