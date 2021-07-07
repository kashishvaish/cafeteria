class OrdersController < ApplicationController
  def index
    render "index"
  end

  def show
    @current_order = Order.find(params[:id])
    render "show"
  end

  def show_all
    if current_user.role == "billing-clerk" or current_user.role == "owner"
      @orders = Order.order_by_id
      render "show_all_orders"
    end
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

  def update
    order = Order.find(params[:id])
    status = params[:status]
    order.update(status: status)
    redirect_to "/all_orders"
  end
end
