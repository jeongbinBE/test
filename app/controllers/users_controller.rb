class UsersController < ApplicationController

  def new
		@user = User.new
  end

	def show
		@user = User.find_by(username: params[:username])
	end
end
