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

  validates :user_name, presence: true

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
