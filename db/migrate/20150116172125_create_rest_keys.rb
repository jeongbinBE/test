class CreateRestKeys < ActiveRecord::Migration
  def change
    create_table :rest_keys do |t|
      t.integer :restaurant_id
      t.integer :cat_code
      t.string :name
      t.text :addr
      t.boolean :delivery

      t.timestamps
    end
		add_index :rest_keys, :restaurant_id, name: 'by_restaurant_id'
		add_index :rest_keys, :cat_code			, name: 'by_cat_code'
		add_index :rest_keys, :name					,	name: 'by_name'
		add_index :rest_keys, :addr					,	name: 'by_addr', 		length: 400
		add_index :rest_keys, :delivery			, name: 'by_delivery'
  end
end
