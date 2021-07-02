class CartItemsController < ApplicationController
  def create
    cart_item = CartItem.new(
      cart_id: current_user.cart.id,
      menu_item_id: params[:menu_item_id],
    )
    if cart_item.save()
      redirect_to "/menu"
    else
      render plain: "Error"
    end
  end

  def destroy
    cart_item = current_user.cart.cart_items.where(menu_item_id: params[:menu_item_id]).last()
    cart_item.destroy
    redirect_to "/menu"
  end
end
