class Menu < ActiveRecord::Base
	belongs_to :menu_title, touch: true
end
