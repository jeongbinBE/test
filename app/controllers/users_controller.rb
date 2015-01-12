class UsersController < ApplicationController
	
	# Before filters
	before_action :logged_in_user?, only: [:edit, :update]
	before_action :correct_user?,   only: [:edit, :update]


  def signup 
		@user = User.new
  end

	def create
    @user = User.new(user_params)
    if @user.save
			log_in @user
			flash[:success] = "MenuMap에 성공적으로 가입하셨습니다."
			redirect_to user_url(@user.username)
    else
			render 'signup'
    end
  end

	def show
		@user = User.find_by(username: params[:username])
	end

	def edit
		@user = User.find_by(username: params[:username])
	end

	def update
		@user = User.find_by(username: params[:username])
		if @user.update_attributes(user_params)
			flash[:success] = "계정 정보를 변경하였습니다."
			redirect_to user_path(@user.username)
		else
			render 'edit'
		end
	end


	private
		def user_params
			params.require(:user).permit(:username, :email, :password,
																	 :password_confirmation)
		end

		# Before filters

		# check if a user is logged in?
		def logged_in_user?
			unless logged_in?
				store_location
				flash[:danger] = "로그인을 해주세요."
				redirect_to login_url
			end
		end

		def correct_user?
			@user = User.find_by(username: params[:username])
			redirect_to(root_url) unless current_user?(@user)
		end
end
