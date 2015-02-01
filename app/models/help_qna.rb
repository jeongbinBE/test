class HelpQna < ActiveRecord::Base

	# validations
	validates :help_title, 		presence: true
	validates :help_contents, presence: true
end
