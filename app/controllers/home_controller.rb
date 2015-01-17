class HomeController < ApplicationController
  def index
  end

  def manual
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

  def help
  end

	def test
	end
end
