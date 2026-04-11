class Customer < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["id", "user_name", "email", "name", "vendor_name", "telephone", "address", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end
end
