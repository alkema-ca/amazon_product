# Rename and repurpose product_pages to be store page requests with request/response object data
class RenameProductPages < ActiveRecord::Migration[5.2]

  def change
    rename_table :product_pages, :page_requests

    add_column :page_requests, :asin, :string

    add_column :page_requests, :status, :integer
  end

end
