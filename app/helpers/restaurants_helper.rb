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
end
