class ReportRestErr < ActiveRecord::Base
	belongs_to :restaurant

	mount_uploader :rest_err_img, RestErrImageUploader 
	validate :picture_size

	private

		# set maximum image size.
		def picture_size
			if picture.size > 10.megabytes
				errors.add(:rest_err_img, "10MB를 넘는 사진입니다.")
			end
		end
end
