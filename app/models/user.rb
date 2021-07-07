class User < ActiveRecord::Base
  scope :filter_by_role, ->(role) { where role: role }
  scope :filter_by_state, ->(state) { where state: state }

  has_secure_password
  has_many :orders
  has_one :cart
end
