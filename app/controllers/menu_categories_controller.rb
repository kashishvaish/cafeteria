class MenuCategoriesController < ApplicationController
  def create
    MenuCategory.create(
      name: params[:name],
      status: "active",
    )
    redirect_to request.referrer
  end

  def edit
    id = params[:id]
    @category = MenuCategory.find(id)
  end

  def update
    id = params[:id]
    category = MenuCategory.find(id)
    category.update(name: params[:name])
    redirect_to "/menu_admin"
  end

  def destroy
    id = params[:id]
    category = MenuCategory.find(id)
    category.destroy
    redirect_to request.referrer
  end

  def change_status
    category = MenuCategory.find(params[:id])
    category.update(status: params[:status])
    redirect_to request.referrer
  end
end
