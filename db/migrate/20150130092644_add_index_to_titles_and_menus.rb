class AddIndexToTitlesAndMenus < ActiveRecord::Migration
  def change
		add_index :menu_titles, :restaurant_id
		add_index :menus, 			:menu_title_id
  end
end
