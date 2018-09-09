# Create categories which holds the ladder of categories
class CreateCategories < ActiveRecord::Migration[5.2]

  def change
    create_table :categories do |t|
      t.belongs_to :product # , foreign_key: true, index: { unique: true }

      t.integer :parent_id
      t.integer :set_id
      t.string :name, null: false
      t.decimal :rank

      t.timestamps null: false
    end
  end

end
