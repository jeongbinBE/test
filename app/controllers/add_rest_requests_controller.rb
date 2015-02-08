class AddRestRequestsController < ApplicationController

  def new
		intro_msg = "더 정확하고 충분한 정보를 입력해주시면 등록이 빨라집니다."
		flash.now[:info] = intro_msg
		@new_rest = AddRestRequest.new

		@cat = Category.all
		@sub = SubCategory.all
  end

	def create
	end
end
