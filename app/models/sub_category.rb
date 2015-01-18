class SubCategory < ActiveRecord::Base

	belongs_to :cateogory

	class << self
		# find out cat_code range.
		def category_range_is?(sub_category_name)
			category_code = SubCategory.find_by(name: sub_category_name).cat_code
			if category_code == 1000000
				[1000000, 2000000]
			elsif category_code % 10000 == 0
				[category_code, category_code + 10000]
			else
				[category_code, category_code + 100]
			end
		end
	end
end
