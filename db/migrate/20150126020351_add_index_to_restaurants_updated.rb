class AddIndexToRestaurantsUpdated < ActiveRecord::Migration
  def change
		add_index :restaurants, :updated_at
  end
end
