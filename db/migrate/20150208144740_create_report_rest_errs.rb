class CreateReportRestErrs < ActiveRecord::Migration
  def change
    create_table :report_rest_errs do |t|
			t.integer :restaurant_id
      t.boolean :presence_err,  default: false
      t.boolean :menu_err,  		default: false 
      t.boolean :phnum_err,  		default: false 
      t.boolean :cat_err,  			default: false 
      t.text :etc

      t.timestamps
    end

		add_index :report_rest_errs, :restaurant_id
  end
end
