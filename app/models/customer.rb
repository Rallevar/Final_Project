class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :orders

  validates :user_name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "user_name", "email", "name", "telephone", "address", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end
end
