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
      if params[:filter] == "all"
        @orders = Order.order_by_id
      elsif params[:filter] == "pending"
        @orders = Order.pending?.order_by_id
      elsif params[:filter] == "delivered"
        @orders = Order.delivered?.order_by_id
      end
      render "show_all_orders"
    end
  end

  def create
    if current_user.role == "customer"
      user_id = current_user.id
    elsif current_user.role == "billing-clerk"
      user_id = 2
    end

    order = Order.create(
      user_id: user_id,
      status: "pending delivery",
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
    redirect_to request.referrer
  end
end
