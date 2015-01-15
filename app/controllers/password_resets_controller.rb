class PasswordResetsController < ApplicationController
	
	# before actions
	before_action :get_user,				 only: [:edit, :update]
	before_action :valid_user,			 only: [:edit, :update]
	before_action :check_expiration, only: [:edit, :update]

  def new
  end

	def create
		@user = User.find_by(email: params[:password_reset][:email].downcase)
		if @user
			@user.create_reset_digest
			@user.send_password_reset_email
			flash[:info] = "입력하신 주소로 이메일이 발송되었습니다. 확인해주세요."
			redirect_to root_url
		else
			flash[:danger] = "존재하지 않는 이메일입니다. 다시 한 번 확인해주세요."
			render 'new'
		end
	end

  def edit
  end

	def update
		if password_blank?
			flash[:danger] = "비밀번호를 빈칸으로 저장할 수 없습니다."
			render 'edit'
		elsif @user.update_attributes(user_params)
			log_in(@user)
			flash[:success] = "비밀번호가 새롭게 저장되었습니다."
			redirect_to user_path(@user.username)
		else
			render 'edit'
		end
	end

	private
		
		def user_params
			params.require(:user).permit(:password, :password_confirmation)
		end

		def password_blank?
			params[:user][:password].blank?
		end
		
		def get_user
			@user = User.find_by(email: params[:email])
		end

		def valid_user
			unless (@user && @user.activated? &&
							@user.authenticated?(:reset, params[:id]))
				redirect_to root_url
			end
		end

		def check_expiration
			if @user.password_reset_expired?
				message  = "비밀번호 설정기한 2시간이 지났습니다."
				message += " 다시 한 번 비밀번호 찾기를 해주세요."
				flash[:danger] = message
				redirect_to new_password_reset_url
			end
		end
end
