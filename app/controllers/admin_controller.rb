class AdminController < ApplicationController
  def menu_admin
    if current_user.customer?
      render "menu_admin"
    end
  end
end
