class Restaurant < ActiveRecord::Base
	has_one :rest_key, dependent: :destroy
	self.per_page = 10
end
