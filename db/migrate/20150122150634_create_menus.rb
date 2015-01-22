class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :menu_title_id
      t.string  :menu_name
      t.string  :menu_side_info
      t.integer :menu_price
      t.string  :menu_info

      t.timestamps
    end
  end
end
