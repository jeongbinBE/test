class CreateAddRestRequests < ActiveRecord::Migration
  def change
    create_table :add_rest_requests do |t|
      t.string :name
      t.string :real_addr
      t.string :taggable_addr
      t.string :phnum
      t.boolean :delivery, 			default: false 
      t.string :cat
      t.string :sub_cat
      t.string :open_at
      t.text :etc

      t.timestamps
    end
  end
end
