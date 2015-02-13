class Restaurant < ActiveRecord::Base

	# one-to-one with keywords and info.
	has_one :rest_key, dependent: :destroy
	has_one :rest_info, dependent: :destroy
	
	# restaurant images
	has_many :rest_imgs, dependent: :destroy
	
	# restaurant-menu_title-menu associations.
	has_many :menu_titles, dependent: :destroy
	has_many :menus, through: :menu_titles

	# mymap
	has_many :mymap_relationships, class_name: "MymapRelationship",
																foreign_key: "mymap_rest_id",
																dependent: 	 :destroy

	# info error
	has_many :report_rest_errs, dependent: :destroy

	# order for posts
	default_scope -> { order(menu_on: :desc, updated_at: :desc) }

	# image upload
	mount_uploader :picture, PictureUploader
	validate :picture_size


	# for restaurant index page's pagination.
	self.per_page = 10

	private

		# set maximum image size.
		def picture_size
			if picture.size > 10.megabytes
				errors.add(:picture, "10MB를 넘는 사진입니다.")
			end
		end
end
