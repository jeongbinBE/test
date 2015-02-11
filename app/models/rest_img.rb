class RestImg < ActiveRecord::Base
	belongs_to :restaurant
	validates :img, :presence => true

	mount_uploader :img, RestImgUploader
	validate :picture_size

	private
		def picture_size
			if img.size > 10.megabytes
				errors.add(:img, "10MB를 넘는 사진입니다.")
			end
		end
end
