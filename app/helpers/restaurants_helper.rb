module RestaurantsHelper
	
	def find_category(cat)
		cat_code = SubCategory.find_by(name: cat).cat_code
		if cat_code == 1000000
			return [1000000, 2000000]
		elsif cat_code % 10000 == 0
			return [cat_code, cat_code + 10000]
		else
			return [cat_code, cat_code + 100]
		end
	end
end
