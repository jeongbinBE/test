module ApplicationHelper

	# returns full titles.
	def full_title(page_title = '')
		base_title = "MenuMap || 온라인 메뉴제공 서비스 메뉴맵"
		if page_title.empty?
			@page_title || base_title
		else
			"#{ page_title } || MenuMap 온라인 메뉴제공 서비스"
		end
	end
end
