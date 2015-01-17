class Restaurant < ActiveRecord::Base
	has_one :rest_key, dependent: :destroy
end
