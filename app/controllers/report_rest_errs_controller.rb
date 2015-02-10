class ReportRestErrsController < ApplicationController

	def create
		@new_err = ReportRestErr.new(report_rest_err_params)
		if @new_err.save
			flash[:success] = "음식점 정보 오류 신고가 접수되었습니다."
			redirect_to root_url
		else
			flash[:danger] = "적어도 한 가지의 정보 오류를 체크해야합니다."
			redirect_to root_url
		end
	end

	def show
	end

	def destroy
	end

	private
		def report_rest_err_params
			params.require(:report_rest_err).permit(:restaurant_id, :presence_err,
																						 	:menu_err, :phnum_err, :cat_err,
																						 	:etc)
		end
end
