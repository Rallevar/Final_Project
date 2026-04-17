=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-17
  Updated: 2026-04-17
=end

class Province < ApplicationRecord
  has_many :customers

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "code", "gst_rate", "pst_rate", "hst_rate", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customers"]
  end
end