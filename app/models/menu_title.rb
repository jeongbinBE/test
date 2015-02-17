class MenuTitle < ActiveRecord::Base
	
	validates :restaurant_id, presence: true
	validates :title_name, 		presence: true
	
	belongs_to :restaurant, touch: true
	has_many :menus, dependent: :destroy

	after_touch :restaurant_update_touch

	private
		def restaurant_update_touch
			self.restaurant.touch
		end
end
