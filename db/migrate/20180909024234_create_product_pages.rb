# Create product_pages which holds page scrapes
class CreateProductPages < ActiveRecord::Migration[5.2]

  def change
    create_table :product_pages do |t|
      t.belongs_to :product, foreign_key: true, index: { unique: true }
      t.text :body

      t.timestamps null: false
    end
  end

end
