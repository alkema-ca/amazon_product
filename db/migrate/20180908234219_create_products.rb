# Create products, the main relation
class CreateProducts < ActiveRecord::Migration[5.2]

  def change
    create_table :products do |t|
      t.string :asin, null: false
      t.index :asin, unique: true

      t.decimal :length
      t.decimal :width
      t.decimal :height
      t.string :dimensions_units

      t.timestamps null: false
    end
  end

end
