class CreateAskQnas < ActiveRecord::Migration
  def change
    create_table :ask_qnas do |t|
      t.string :qna_user
      t.text :qna_contents

      t.timestamps
    end
  end
end
