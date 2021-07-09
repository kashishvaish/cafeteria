class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :role, presence: true

  scope :filter_by_role, ->(role) { where role: role }

  has_secure_password
  has_many :orders
  has_one :cart

  def owner?
    role == "owner"
  end

  def customer?
    role == "customer"
  end

  def billing_clerk?
    role == "billing-clerk"
  end
end
