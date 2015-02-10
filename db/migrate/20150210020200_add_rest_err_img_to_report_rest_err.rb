class AddRestErrImgToReportRestErr < ActiveRecord::Migration
  def change
    add_column :report_rest_errs, :rest_err_img, :string
  end
end
