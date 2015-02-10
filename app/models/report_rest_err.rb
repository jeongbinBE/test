class ReportRestErr < ActiveRecord::Base
	belongs_to :restaurant
	mount_uploader :rest_err_img, RestErrImageUploader 
end
