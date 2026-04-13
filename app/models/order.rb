=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

class Order < ApplicationRecord
  belongs_to :customer

  def self.ransackable_attributes(auth_object = nil)
    ["id", "customer_id", "status", "total_cost", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items"]
  end
end
