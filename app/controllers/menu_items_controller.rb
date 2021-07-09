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
      item.save()
      redirect_to "/menu_admin"
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
      item.update(
        name: params[:name],
        description: params[:description],
        price: params[:price],
      )
      redirect_to "/menu_admin"
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
