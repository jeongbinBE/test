class AddRestRequest < ActiveRecord::Base
	validates :name, presence: true
	validates :real_addr, presence: true

	mount_uploader :add_rest_img, AddRestImageUploader
	validate :picture_size

	# order for addrequest on admin 
	default_scope -> { order(created_at: :desc) }

	private

		# set maximum image size.
		def picture_size
			if picture.size > 10.megabytes
				errors.add(:picture, "10MB를 넘는 사진입니다.")
			end
		end
end
