class Order < ApplicationRecord
  belongs_to :customer

  def self.ransackable_attributes(auth_object = nil)
    ["id", "customer_id", "status", "total_cost", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items"]
  end
end
