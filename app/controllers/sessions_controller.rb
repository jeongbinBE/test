class SessionsController < ApplicationController
  def new
  end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user
			if user.authenticate(params[:session][:password])
				# when successful login
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
	end
end
