class CreateAutocompletes < ActiveRecord::Migration
  def change
    create_table :autocompletes do |t|
      t.string :name

      t.timestamps
    end

		add_index :autocompletes, :name
  end
end
