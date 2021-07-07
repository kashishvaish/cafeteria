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

  def self.order_by_date
    order(:created_at)
  end

  def self.order_by_id
    order(:id)
  end

  def self.delivered?
    where(status: "delivered")
  end

  def self.pending?
    where.not(status: "delivered")
  end
end
