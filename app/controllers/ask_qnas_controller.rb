class AskQnasController < ApplicationController

	def create
    @qna = AskQna.new(qna_params)
    if @qna.save
			flash[:success] = "질문이 등록되었습니다."
    else
			flash[:danger] = "질문 등록에 실패했습니다."
    end
		redirect_to help_url
	end

	def destroy
	end

	private
		def qna_params 
			params.require(:ask_qna).permit(:qna_user, :qna_contents)
		end
end
