class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :user_cart

  def new
    render "users/new"
  end

  def create
    role = "customer"
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      role: role,
    )
    if user.save
      session[:current_user_id] = user.id
      redirect_to home_path
    else
      rendirect_to new_user_path
    end
  end
end
