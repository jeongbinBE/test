class AddRestRequest < ActiveRecord::Base
	validates :name, presence: true
	validates :real_addr, presence: true
end
