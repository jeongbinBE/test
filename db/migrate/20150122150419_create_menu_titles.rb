class CreateMenuTitles < ActiveRecord::Migration
  def change
    create_table :menu_titles do |t|
      t.integer :restaurant_id
      t.string :title_name
      t.string :title_info

      t.timestamps
    end
  end
end
