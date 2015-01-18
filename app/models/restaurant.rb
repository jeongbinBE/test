class Restaurant < ActiveRecord::Base

	has_one :rest_key, dependent: :destroy

	# for restaurant index page's pagination.
	self.per_page = 10
end
