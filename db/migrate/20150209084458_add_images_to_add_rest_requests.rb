class AddImagesToAddRestRequests < ActiveRecord::Migration
  def change
    add_column :add_rest_requests, :add_rest_img, :string
  end
end
