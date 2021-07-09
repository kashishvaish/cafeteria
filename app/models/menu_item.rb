class MenuItem < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  belongs_to :menu_category

  def self.order_by_id
    order(:id)
  end
end
