=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  validates :customer_id, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: ["new", "paid", "shipped"] }
  validates :total_cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_address, presence: true, length: { maximum: 255 }
  validates :province_name, presence: true, length: { maximum: 100 }
  validates :subtotal, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :gst_rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :pst_rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :hst_rate, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :gst_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :pst_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :hst_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "customer_id", "status", "total_cost", "shipping_address", "province_name", "subtotal", "gst_rate", "pst_rate", "hst_rate", "gst_amount", "pst_amount", "hst_amount", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items"]
  end
end
