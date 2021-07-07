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

  def self.total_sale
    sale = 0
    all().each do |order|
      sale += order.total
    end
    return sale
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

  def self.between(start_date, end_date)
    if start_date && end_date
      where("created_at BETWEEN ? AND ?", start_date.to_date.beginning_of_day, end_date.to_date.end_of_day)
    else
      where(id: 0)
    end
  end
end
