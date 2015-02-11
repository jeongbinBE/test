class RestImgsController < ApplicationController

	def create
		@new = RestImg.new(rest_imgs_params)
		if @new.save
			flash[:success] = "음식점 사진이 저장되었습니다!"
			redirect_to :back
		else
			flash[:danger] = "적어도 하나의 사진을 저장해야합니다."
			redirect_to :back
		end
	end

	def destroy
	end

	private
		def rest_imgs_params
			params.require(:rest_img).permit(:restaurant_id, :img)
		end
end
