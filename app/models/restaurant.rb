class Restaurant < ActiveRecord::Base

	has_one :rest_key, dependent: :destroy
	
	# restaurant-menu_title-menu associations.
	has_many :menu_titles, dependent: :destroy
	has_many :menus, through: :menu_titles

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
			if picture.size > 5.megabytes
				errors.add(:picture, "5MB를 넘는 사진입니다.")
			end
		end
end
