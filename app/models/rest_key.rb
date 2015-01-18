class RestKey < ActiveRecord::Base

	# association(one-to-one with Restaurant Model)
	belongs_to :restaurant

	class << self

		# search algorithm for restaurant index page
		def search(delivery, category, name, address)
			@rest_key = RestKey.all
			@rest_key = @rest_key.filter_delivery(delivery) if delivery == "1"
			@rest_key = @rest_key.filter_category(category) 
			@rest_key = @rest_key.filter_name(name) 			unless name.blank?
			@rest_key = @rest_key.filter_address(address) unless address.blank?
			@rest_key
		end

		def filter_delivery(delivery)
			where(delivery: delivery)
		end

		def filter_category(category_name)
			range = SubCategory.category_range_is?(category_name)
			where("cat_code >= :start AND cat_code < :end",
												{ start: range[0], end: range[1] })
		end
		
		def filter_address(address)
			array = address.downcase.split
			where("rest_keys.addr LIKE ? AND rest_keys.addr LIKE ? AND 
						 rest_keys.addr LIKE ? AND rest_keys.addr LIKE ?", 
																				"%#{array[0]}%", "%#{array[1]}%",
																				"%#{array[2]}%", "%#{array[3]}%")
		end

		def filter_name(name)
			array = name.downcase.split
			where("rest_keys.name LIKE ? AND rest_keys.name LIKE ? AND 
						 													 rest_keys.name LIKE ?",
														"%#{array[0]}%", "%#{array[1]}%", "%#{array[2]}%")
		end

	end

end
