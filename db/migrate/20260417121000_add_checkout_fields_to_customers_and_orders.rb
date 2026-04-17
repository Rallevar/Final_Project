=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-17
=end

class AddCheckoutFieldsToCustomersAndOrders < ActiveRecord::Migration[7.2]
  def change
    add_reference :customers, :province, foreign_key: true

    add_column :orders, :shipping_address, :string
    add_column :orders, :province_name, :string
    add_column :orders, :subtotal, :decimal, precision: 10, scale: 2
    add_column :orders, :gst_rate, :decimal, precision: 6, scale: 5
    add_column :orders, :pst_rate, :decimal, precision: 6, scale: 5
    add_column :orders, :hst_rate, :decimal, precision: 6, scale: 5
    add_column :orders, :gst_amount, :decimal, precision: 10, scale: 2
    add_column :orders, :pst_amount, :decimal, precision: 10, scale: 2
    add_column :orders, :hst_amount, :decimal, precision: 10, scale: 2
  end
end