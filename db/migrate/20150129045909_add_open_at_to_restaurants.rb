class AddOpenAtToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :open_at, :string
  end
end
