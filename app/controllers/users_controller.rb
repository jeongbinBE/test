class UsersController < ApplicationController
	
	# Before filters
	before_action :logged_in_user?, only: [:edit,  :update, 
																				 :index, :destroy] # index -> admin
	before_action :correct_user?,   only: [:edit,  :update]
	before_action :admin_user?, 		only: :destroy

  def signup 
		@user = User.new
  end

	def create
    @user = User.new(user_params)
    if @user.save
			@user.send_activation_email
			flash[:info] = "이메일을 확인해주시면 회원가입이 완료됩니다."
			redirect_to root_url
    else
			render 'signup'
    end
  end

	def index
		@users = User.paginate(page: params[:page], :per_page => 5)
	end

	def show
		@user = User.find_by(username: params[:username])
		# only activated user can access their page
		redirect_to root_url and return unless @user.activated == true
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

	def destroy
		User.find_by(username: params[:username]).destroy
		flash[:success] = "계정이 삭제되었습니다."
		redirect_to users_url
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

		def admin_user?
			redirect_to(root_url) unless current_user.admin?
		end
end
