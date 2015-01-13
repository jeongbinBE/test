class AccountActivationsController < ApplicationController
	
	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.update_attribute(:activated, 	 true)
			user.update_attribute(:activated_at, Time.now)
			log_in user
			flash[:success] = "계정이 활성화되었습니다. MenuMap에 오신것을 환영합니다."
			redirect_to user_url(user.username)
		else
			flash[:danger] = "계정 활성화에 실패하였습니다. 다시 한 번 확인해주세요."
			redirect_to root_url
		end
	end
end
