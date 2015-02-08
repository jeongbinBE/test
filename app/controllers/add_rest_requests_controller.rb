class AddRestRequestsController < ApplicationController

  def new
		intro_msg = "더 정확하고 충분한 정보를 입력해주시면 등록이 빨라집니다."
		flash.now[:info] = intro_msg if flash.empty?
		@new_rest = AddRestRequest.new

		@cat = Category.all
		@sub = SubCategory.all
  end

	def create
		@new_rest = AddRestRequest.new(addrest_params)
		@new_rest.cat = Category.find_by(id: params[:category]).name
		@new_rest.sub_cat = params[:sub_category]
    if @new_rest.save
			flash[:success] = "음식점 추가 신청이 접수되었습니다."
			redirect_to new_add_rest_request_url
    else
			flash[:danger] = "업소명, 주소는 필수기재 항목입니다."
			redirect_to new_add_rest_request_url
    end
	end

	private
		def addrest_params
			params.require(:add_rest_request).permit(:name, :real_addr, :taggable_addr,
																							 :cat, :sub_cat, :phnum, :delivery,
																							 :open_at, :etc)
		end
end
