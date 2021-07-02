class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in
  before_action :user_cart

  def ensure_user_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def user_cart
    if current_user.cart.blank?
      Cart.create(
        user_id: current_user.id,
      )
    end
    @user_cart = current_user.cart
  end

  def current_user
    return @current_user if @current_user

    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end
end
