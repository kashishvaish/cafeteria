class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :user_cart

  def index
    if current_user
      if current_user.role == "customer"
        render "index"
      elsif current_user.role == "billing-clerk"
        render "billing_clerk_home"
      elsif current_user.role == "owner"
        render "index"
      end
    else
      render "index"
    end
  end
end
