class CommentsController < ApplicationController
	
	def create
		@new = Comment.new(comment_params)
		if @new.save
			flash[:success] = "댓글이 등록되었습니다."
			redirect_to :back
		else
			flash[:danger] = "댓글 내용을 작성해주세요." # 없으면 아예 submit 안되도록
			redirect_to :back
		end
		# create.js.erb로 respond_to |format|
	end

	def update
	end

	def destroy
		@target = Comment.find(params[:id]).destroy
		flash[:success] = "댓글이 삭제되었습니다."
		redirect_to :back
		# Ajax로 되도록
	end

	private
		def comment_params
			params.require(:comment).permit(:user_id, :restaurant_id, :contents)
		end
end
