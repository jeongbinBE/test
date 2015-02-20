class MenusController < ApplicationController
	before_action :correct_user?, only: [:destroy], if: :not_admin_user?
	
	def create
		if params[:title_name].blank?
			@new_menu = Menu.new(menu_params)
			if @new_menu.save
				create_redirection
			else
				flash[:danger] = "메뉴를 저장하지 못했습니다."
				create_redirection
			end
		else
			@new_title = MenuTitle.new(menu_title_params)
			if @new_title.save
				@new_menu = @new_title.menus.new(menu_wo_title_params)
				if @new_menu.save
					create_redirection
				else
					flash[:danger] = "메뉴를 저장하지 못했습니다."
					create_redirection
				end
			else
				flash[:danger] = "메뉴목록을 저장하지 못했습니다."
				create_redirection
			end
		end
	end

	def update
	end

	def destroy
		@target = Menu.find(params[:id])
		@title = @target.menu_title
		@restaurant = @target.menu_title.restaurant
		@titles = @restaurant.menu_titles
		@menus = @restaurant.menus
		@menu = Menu.new
		@target.destroy
		@title.destroy if @title.menus.empty?
		if ( @restaurant.menu_on == 1 || @restaurant.menu_on == 11 ) &&
				 @restaurant.menus.empty?
			@restaurant.update(menu_on: 0)
		end
		respond_to do |format|
			format.html { redirect_to @titles }
			format.js {}
		end
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

		def create_redirection
			@restaurant = @new_menu.menu_title.restaurant
			@titles = @restaurant.menu_titles
			@menus = @restaurant.menus
			@menu = Menu.new
			if @restaurant.menu_on == 0 || @restaurant.menu_on.nil?
				@restaurant.update(menu_on: 1)
			end
			respond_to do |format|
				format.html { redirect_to @titles }
				format.js {}
			end
		end

		def correct_user?
			@user = Comment.find(params[:id]).user
			redirect_to :back unless current_user?(@user)
		end

		def not_admin_user?
			!current_user.admin?
		end
end
