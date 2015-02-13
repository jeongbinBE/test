class CreateMymapRelationships < ActiveRecord::Migration
  def change
    create_table :mymap_relationships do |t|
      t.integer :mymap_user_id
      t.integer :mymap_rest_id

      t.timestamps
    end

		add_index :mymap_relationships, :mymap_user_id
		add_index :mymap_relationships, :mymap_rest_id
		add_index :mymap_relationships, [:mymap_user_id, :mymap_rest_id], unique: true
  end
end
