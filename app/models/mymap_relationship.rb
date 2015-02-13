class MymapRelationship < ActiveRecord::Base
	belongs_to :mymap_user, class_name: "User"
	belongs_to :mymap_rest, class_name: "Restaurant"
	validates :mymap_user_id, presence: true
	validates :mymap_rest_id, presence: true
end
