=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-19
=end

class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  belongs_to :province, optional: true
  has_many :orders

  validates :user_name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :name, length: { maximum: 100 }, allow_blank: true
  validates :telephone,
            length: { maximum: 25 },
            format: { with: /\A[0-9\-\(\)\+\s]+\z/, message: "must be a valid phone number" },
            allow_blank: true
  validates :address, length: { maximum: 255 }, allow_blank: true
  validates :province_id, numericality: { only_integer: true }, allow_nil: true

  def province_code
    province&.code
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "user_name", "email", "name", "telephone", "address", "province_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "province"]
  end
end
