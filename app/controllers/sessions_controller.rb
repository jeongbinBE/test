class SessionsController < ApplicationController
  def new
  end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user
			if user.authenticate(params[:session][:password])
				if user.activated?	
					log_in user
					params[:session][:remember_me] == '1' ? remember(user) : forget(user)
					redirect_back_or user_url(user.username)
				else
					message = "잘못된 링크로 인해 계정이 활성화되지 않았습니다."
					message += " 이메일을 다시 한 번 확인해주세요."
					flash[:warning] = message
					redirect_to root_url
				end
			else
				flash.now[:danger] = "비밀번호가 잘못되었습니다."
				render 'new'
			end
		else
			flash.now[:warning] = "존재하지 않는 이메일(ID)입니다."
			render 'new'
		end
	end

	def destroy
		log_out if logged_in?
		redirect_to root_url
	end
end
