class UsersController < ApplicationController

  def new
		@user = User.new
  end

	def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
    else
			render 'new'
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
