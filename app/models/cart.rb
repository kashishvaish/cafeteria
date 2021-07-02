class Cart < ActiveRecord::Base
  has_many :cart_items
  belongs_to :user

  def total
    sum = 0
    cart_items.each do |item|
      sum += item.menu_item.price
    end
    return sum
  end
end
