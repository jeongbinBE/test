class HomeController < ApplicationController
	include ActionView::Helpers::NumberHelper

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
		@restaurants = Restaurant.where("id = ? OR id = ? OR id = ?", 
																		 1000000, 1099572, 1120855)
		@restaurant = Restaurant.find(1000000)
		@titles = @restaurant.menu_titles
		@menus  = @restaurant.menus
  end

  def search
		@cat = Category.all
		@sub = SubCategory.all
  end

	def update_sub_categories
		@sub = SubCategory.where("category_id = ?", params[:category_id])
		respond_to do |format|
			format.js
		end
	end

	def test
		@ask_qnas = AskQna.all
		@new_rest = AddRestRequest.all
		@new_err  = ReportRestErr.all
		@imgs = RestImg.where(restaurant_id: 1016368)
	end
end
