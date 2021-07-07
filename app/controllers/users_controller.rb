class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :user_cart

  def show_all
    @users = User.all()
    @users = @users.filter_by_role(params[:role]) if params[:role].present?
    @users = @users.filter_by_role(params[:state]) if params[:state].present?
    render "show_all"
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if current_user
      if current_user.role == "owner"
        render "users/new"
      else
        redirect_to "/"
      end
    else
      render "users/new"
    end
  end

  def create
    role = "customer"
    if current_user && current_user.role == "owner"
      role = params[:role]
    end
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      role: role,
    )
    if user.save
      if current_user
        redirect_to home_path
      else
        session[:current_user_id] = user.id
        redirect_to new_user_path
      end
    end
  end

  def destroy
    id = params[:id]
    user = User.find(id)
    user.destroy
    redirect_to request.referrer
  end
end
