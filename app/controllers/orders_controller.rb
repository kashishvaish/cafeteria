class OrdersController < ApplicationController
  def index
    render "index"
  end

  def show
    @current_order = Order.find(params[:id])
    render "show"
  end

  def show_all
    if current_user.billing_clerk? || current_user.owner?
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

  def generate_report
    if current_user.owner?
      if params[:order_id]
        @orders = Order.where(id: params[:order_id])
        render "generate_report"
      elsif params[:start_date]
        @start_date = params[:start_date]
        @end_date = params[:end_date]
        @orders = Order.between(@start_date, @end_date)
        if params[:user_id].blank? == false
          @orders = @orders.where(user_id: params[:user_id])
        end
        @total_sale = @orders.total_sale
        render "generate_report"
      else
        @orders = Order.all()
      end
    end
  end

  def create
    if current_user.customer?
      user_id = current_user.id
      current_user.update(
        state: params[:state],
        city: params[:city],
        address: params[:address],
        contact_no: params[:contact_no],
      )
    elsif current_user.billing_clerk?
      user_id = 2
    end

    order = Order.new(
      user_id: user_id,
      status: "pending delivery",
    )

    if order.save
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
      if current_user.billing_clerk?
        flash[:notice] = "Order Placed Successfully With ID: #{order.id}"
        redirect_to "/menu"
      else
        flash[:notice] = "Order Placed Successfully!"
        redirect_to "/menu"
      end
    end
  end

  def update
    if current_user.billing_clerk? || current_user.owner?
      order = Order.find(params[:id])
      order.update(status: "delivered")
      redirect_to request.referrer
    end
  end
end
