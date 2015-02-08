class AddRestRequest < ActiveRecord::Base
	validates :name, presence: true
	validates :real_addr, presence: true

	# order for addrequest on admin 
	default_scope -> { order(created_at: :desc) }

end
