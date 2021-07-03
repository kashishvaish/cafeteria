class OrdersController < ApplicationController
  def index
    render "index"
  end

  def create
    if current_user.role == "customer"
      user_id = current_user.id
      status = "pending delivery"
    end

    order = Order.create(
      user_id: user_id,
      status: status,
    )

    user_cart.cart_items.each do |item|
      OrderItem.create(
        order_id: order.id,
        menu_item_id: item.menu_item.id,
        menu_item_name: item.menu_item.name,
        menu_item_price: item.menu_item.price,
      )
      item.destroy
    end
    user_cart.destroy
    redirect_to "/menu"
  end
end
