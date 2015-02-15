class CommentsController < ApplicationController
	before_action :correct_user?, only: [:destroy], if: :not_admin_user?
	
	def create
		@comment = Comment.new(comment_params)
		@comments = @comment.restaurant.comments
		respond_to do |format|
			if @comment.save
				format.html { redirect_to @comments }
				format.js {}
			else
				flash[:alert] = "댓글 저장 오류"
			end
		end
	end

	def update
	end

	def destroy
		@target = Comment.find(params[:id])
		@restaurant = @target.restaurant
		@target.destroy
		@comments = @restaurant.comments
		respond_to do |format|
			format.html { redirect_to @comments }
			format.js
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:user_id, :restaurant_id, :contents)
		end

		def correct_user?
			@user = Comment.find(params[:id]).user
			redirect_to :back unless current_user?(@user)
		end

		def not_admin_user?
			!current_user.admin?
		end
end
