class HelpQnasController < ApplicationController
  def index
		@qnas = HelpQna.all
  end

  def new
		@qna = HelpQna.new
  end

	def create
		@qna = HelpQna.new(help_params)
		if @qna.save
			flash[:info] = "성공"
			redirect_to '/help/test'
		else
			flash[:error] = "실패"
			redirect_to '/help/test'
		end
	end

  def edit
		@qna = HelpQna.find_by(id: params[:id])
  end

	def update
		@qna = HelpQna.find_by(id: params[:id])
		if @qna.update_attributes(help_params)
			flash[:success] = "변경 됐음."
			redirect_to '/help/test'
		else
			flash[:error] = "변경 실패"
			render 'edit'
		end
	end

	private 
		def help_params
			params.require(:help_qna).permit(:help_title, :help_contents)
		end
end
