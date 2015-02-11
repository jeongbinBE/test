class AddOwnerIntroToRestInfos < ActiveRecord::Migration
  def change
    add_column :rest_infos, :owner_intro, :text
  end
end
