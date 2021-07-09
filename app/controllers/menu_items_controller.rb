class MenuItemsController < ApplicationController
  def new
    if current_user.owner?
      @category_id = params[:id]
      render "new"
    end
  end

  def create
    if current_user.owner?
      item = MenuItem.new(
        menu_category_id: params[:menu_category_id],
        name: params[:name],
        description: params[:description],
        price: params[:price],
      )
      if item.save()
        flash[:notice] = "New Item Added Successfully!"
        redirect_to "/menu_admin"
      else
        flash[:error] = item.errors.full_messages.join(", ")
        redirect_to request.referrer
      end
    end
  end

  def edit
    if current_user.owner?
      id = params[:id]
      @item = MenuItem.find(id)
    end
  end

  def update
    if current_user.owner?
      id = params[:id]
      item = MenuItem.find(id)
      item.name = params[:name]
      item.description = params[:description]
      item.price = params[:price]

      if item.save
        flash[:notice] = "Item Updated Successfully!"
        redirect_to "/menu_admin"
      else
        flash[:error] = item.errors.full_messages.join(", ")
        redirect_to request.referrer
      end
    end
  end

  def destroy
    if current_user.owner?
      id = params[:id]
      item = MenuItem.find(id)
      item.destroy
      redirect_to request.referrer
    end
  end
end
