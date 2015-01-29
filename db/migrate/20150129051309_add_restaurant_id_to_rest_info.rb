class AddRestaurantIdToRestInfo < ActiveRecord::Migration
  def change
    add_column :rest_infos, :restaurant_id, :integer
		add_index  :rest_infos, :restaurant_id
  end
end
