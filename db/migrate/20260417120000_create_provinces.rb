=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-17
=end

class CreateProvinces < ActiveRecord::Migration[7.2]
  def change
    create_table :provinces do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.decimal :gst_rate, precision: 6, scale: 5, null: false, default: 0
      t.decimal :pst_rate, precision: 6, scale: 5, null: false, default: 0
      t.decimal :hst_rate, precision: 6, scale: 5, null: false, default: 0

      t.timestamps
    end

    add_index :provinces, :name, unique: true
    add_index :provinces, :code, unique: true
  end
end