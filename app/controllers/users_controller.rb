class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :user_cart

  def show_all
    if current_user.owner?
      @users = User.all()
      @users = @users.filter_by_role(params[:role]) if params[:role].present?
      @users = @users.filter_by_role(params[:state]) if params[:state].present?
      render "show_all"
    end
  end

  def show
    if current_user.owner? || current_user.billing_clerk?
      @user = User.find(params[:id])
    end
  end

  def new
    if current_user
      if current_user.owner?
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
    if current_user && current_user.owner?
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
        flash[:notice] = "New User Created Successfully!"
        redirect_to request.referrer
      else
        session[:current_user_id] = user.id
        redirect_to new_user_path
      end
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def destroy
    if current_user.owner?
      id = params[:id]
      if id != 1 && id != 2
        user = User.find(id)
        user.destroy
        redirect_to request.referrer
      else
        redirect_to request.referrer
      end
    end
  end
end
