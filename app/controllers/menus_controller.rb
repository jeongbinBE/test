class MenusController < ApplicationController
	
	def create
		if params[:title_name].blank?
			@new_menu = Menu.new(menu_params)
			if @new_menu.save
				restaurant = @new_menu.menu_title.restaurant
				if restaurant.menu_on == 0 || restaurant.menu_on.nil?
					restaurant.update(menu_on: 1)
				end
				flash[:success] = "메뉴를 성공적으로 저장했습니다."
				redirection
			else
				flash[:danger] = "메뉴를 저장하지 못했습니다."
				redirection
			end
		else
			@new_title = MenuTitle.new(menu_title_params)
			if @new_title.save
				@new_menu = @new_title.menus.new(menu_wo_title_params)
				if @new_menu.save
					restaurant = @new_menu.menu_title.restaurant
					if restaurant.menu_on == 0 || restaurant.menu_on.nil?
						restaurant.update(menu_on: 1)
					end
					flash[:success] = "새로운 메뉴목록과 메뉴를 등록했습니다."
					redirect_to :back
				else
					flash[:danger] = "메뉴를 저장하지 못했습니다."
					redirect_to :back
				end
			else
				flash[:danger] = "메뉴목록을 저장하지 못했습니다."
				redirect_to :back
			end
		end
	end

	def update
	end

	def destroy
	end

	private
		def menu_params
			params.require(:menu).permit(:menu_title_id, :menu_name, :menu_price, 
																	 :menu_side_info, :menu_info, :user_id)
		end

		def menu_title_params
			params.permit(:restaurant_id, :title_name, :title_info)
		end

		def menu_wo_title_params
			params.require(:menu).permit(:menu_name, :menu_price,
																	 :menu_side_info, :menu_info, :user_id)
		end

		def redirection
			redirect_to :back
		end
end
