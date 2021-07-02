class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_one :cart
end
