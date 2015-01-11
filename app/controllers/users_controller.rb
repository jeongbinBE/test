class UsersController < ApplicationController

  def signup 
		@user = User.new
  end

	def create
    @user = User.new(user_params)
    if @user.save
			flash[:success] = "MenuMap에 성공적으로 가입하셨습니다."
			redirect_to user_url(@user.username)
    else
			render 'signup'
    end
  end

	def show
		@user = User.find_by(username: params[:username])
	end


	private
		def user_params
			params.require(:user).permit(:username, :email, :password,
																	 :password_confirmation)
		end
end
