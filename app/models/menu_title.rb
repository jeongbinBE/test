class MenuTitle < ActiveRecord::Base
	belongs_to :restaurant
	has_many :menus, dependent: :destroy

	after_touch :restaurant_update_touch

	private
		def restaurant_update_touch
			self.restaurant.touch
		end
end
