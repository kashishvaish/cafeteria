class OrderItemsController < ApplicationController
  def create
    order_id = current_user.orders.last.id
    user_cart.cart_items.each do |item|
      OrderItem.create(
        order_id: order_id,
        menu_item_id: item.menu_item.id,
        menu_item_name: item.menu_item.name,
        menu_item_price: item.menu_item.price,
      )
    end
    redirect_to "/menu"
  end
end
