class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :user_cart

  def index
    if current_user
      render "index"
    else
      render "index"
    end
  end
end
