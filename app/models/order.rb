class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  def total
    sum = 0
    order_items.each do |item|
      sum += item.menu_item.price
    end
    return sum
  end
end
