class Menu < ActiveRecord::Base
	
	validates :menu_title_id, presence: true
	validates :menu_name, 		presence: true
	validates :menu_price, 		
						:presence  		=> true,
						:numericality => { only_integer: true }

	belongs_to :menu_title, touch: true
end
