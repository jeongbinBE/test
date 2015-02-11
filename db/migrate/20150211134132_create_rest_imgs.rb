class CreateRestImgs < ActiveRecord::Migration
  def change
    create_table :rest_imgs do |t|
      t.integer :restaurant_id
      t.string :img

      t.timestamps
    end

		add_index :rest_imgs, :restaurant_id
  end
end
