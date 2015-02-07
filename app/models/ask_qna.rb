class AskQna < ActiveRecord::Base
	validates :qna_contents, :presence => { :message => "궁금하신 점을 입력해주세요." }
end
