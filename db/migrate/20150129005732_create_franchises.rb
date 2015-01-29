class CreateFranchises < ActiveRecord::Migration
  def change
    create_table :franchises do |t|
      t.integer :fn
      t.integer :restaurant

      t.timestamps
    end
  end
end
