class AboutPage < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :telephone, presence: true
  validates :address, presence: true
  validates :email, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "content", "telephone", "address", "email", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end