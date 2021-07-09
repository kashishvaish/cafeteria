class MenuCategoriesController < ApplicationController
  def create
    if current_user.owner?
      MenuCategory.create(
        name: params[:name],
        status: "active",
      )
      redirect_to request.referrer
    end
  end

  def edit
    if current_user.owner?
      id = params[:id]
      @category = MenuCategory.find(id)
    end
  end

  def update
    if current_user.owner?
      id = params[:id]
      category = MenuCategory.find(id)
      category.update(name: params[:name])
      redirect_to "/menu_admin"
    end
  end

  def destroy
    if current_user.owner?
      id = params[:id]
      category = MenuCategory.find(id)
      category.destroy
      redirect_to request.referrer
    end
  end

  def change_status
    if current_user.owner?
      category = MenuCategory.find(params[:id])
      category.update(status: params[:status])
      redirect_to request.referrer
    end
  end
end
