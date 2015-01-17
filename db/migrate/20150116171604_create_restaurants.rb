class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :cat
      t.string :sub_cat
      t.string :addr
      t.string :phnum
      t.boolean :delivery
      t.integer :menu_on

      t.timestamps
    end
  end
end
