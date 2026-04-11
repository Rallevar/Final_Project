class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :product_name
      t.decimal :cost, precision: 10, scale: 2
      t.integer :stock_quantity
      t.decimal :weight, precision: 10, scale: 2
      t.string :origin_country
      t.text :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
