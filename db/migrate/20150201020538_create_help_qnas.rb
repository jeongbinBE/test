class CreateHelpQnas < ActiveRecord::Migration
  def change
    create_table :help_qnas do |t|
      t.string :help_title
      t.text 	 :help_contents

      t.timestamps
    end
  end
end
