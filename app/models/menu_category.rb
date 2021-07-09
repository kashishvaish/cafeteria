class MenuCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :menu_items

  def self.order_by_id
    order(:id)
  end
end
