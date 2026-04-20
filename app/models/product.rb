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

  validates :product_name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :origin_country, length: { maximum: 100 }, allow_blank: true
  validates :description, presence: true
  validates :category_id, presence: true, numericality: { only_integer: true }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "product_name", "cost", "stock_quantity", "weight", "origin_country", "description", "category_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "image_attachment"]
  end
end
