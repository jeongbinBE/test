class Comment < ActiveRecord::Base
	
	validates :user_id, presence: true
	validates :restaurant_id, presence: true
	validates :contents, presence: true

	belongs_to :restaurant
	belongs_to :user
end
