=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    ["id", "product_name", "cost", "stock_quantity", "weight", "origin_country", "description", "category_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "image_attachment"]
  end
end
