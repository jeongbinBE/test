module RestaurantsHelper

	def short_addr(addr)
		addr.split.take(3).pop(2).join(" ")
	end

	def css_on_menu(arg)
		if arg == 11
			"success"
		elsif arg == 1
			"warning"
		else
			"default"
		end
	end

	def words_on_menu(arg)
		if arg == 11
			"메뉴등록 완료"
		elsif arg == 1
			"메뉴 등록중"
		else
			"메뉴 미등록"
		end
	end

	def delivery_css(arg)
		if arg
			"del"
		else
			"nodel"
		end
	end

	def two_menus(arg)
		if arg[1].blank?
			arg[0].menu_name
		else
			arg[0].menu_name + ", " + arg[1].menu_name
		end
	end
end
