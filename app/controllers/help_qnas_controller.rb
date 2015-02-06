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
			redirect_to help_url
		else
			flash[:danger] = "실패"
			redirect_to new_help_qna_url
		end
	end

  def edit
		@qna = HelpQna.find_by(id: params[:id])
  end

	def update
		@qna = HelpQna.find_by(id: params[:id])
		if @qna.update_attributes(help_params)
			flash[:success] = "변경 됐음."
			redirect_to help_url
		else
			flash[:danger] = "변경 실패"
			render edit_help_qna_url
		end
	end

	def destroy
		HelpQna.find_by(id: params[:id]).destroy
		flash[:success] = "지웠음"
		redirect_to help_url
	end

	private 
		def help_params
			params.require(:help_qna).permit(:help_title, :help_contents)
		end
end
