class MenuItemsController < ApplicationController
  def new
    @category_id = params[:id]
    render "new"
  end

  def create
    item = MenuItem.new(
      menu_category_id: params[:menu_category_id],
      name: params[:name],
      description: params[:description],
      price: params[:price],
    )
    item.save()
    redirect_to "/menu_admin"
  end

  def edit
    id = params[:id]
    @item = MenuItem.find(id)
  end

  def update
    id = params[:id]
    item = MenuItem.find(id)
    item.update(
      name: params[:name],
      description: params[:description],
      price: params[:price],
    )
    redirect_to "/menu_admin"
  end

  def destroy
    id = params[:id]
    item = MenuItem.find(id)
    item.destroy
    redirect_to request.referrer
  end
end
