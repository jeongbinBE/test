class Restaurant < ActiveRecord::Base

	has_one :rest_key, dependent: :destroy
	
	# restaurant-menu_title-menu associations.
	has_many :menu_titles, dependent: :destroy
	has_many :menus, through: :menu_titles

	# for restaurant index page's pagination.
	self.per_page = 10
end
