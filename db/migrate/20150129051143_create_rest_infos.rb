class CreateRestInfos < ActiveRecord::Migration
  def change
    create_table :rest_infos do |t|
      t.string :title_addr
      t.string :gm_addr

      t.timestamps
    end
  end
end
