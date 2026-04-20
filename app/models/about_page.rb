=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

class AboutPage < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :telephone, presence: true,
                        length: { maximum: 25 },
                        format: { with: /\A[0-9\-\(\)\+\s]+\z/, message: "must be a valid phone number" }
  validates :address, presence: true, length: { maximum: 255 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "content", "telephone", "address", "email", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end