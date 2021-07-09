class MenuCategoriesController < ApplicationController
  def create
    if current_user.owner?
      category = MenuCategory.new(
        name: params[:name],
        status: "active",
      )
      if category.save
        flash[:notice] = "New Category Created Successfully!"
        redirect_to request.referrer
      else
        flash[:error] = category.errors.full_messages.join(", ")
        redirect_to request.referrer
      end
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
      category.name = params[:name]
      if category.save
        flash[:notice] = "Menu Category Renamed Successfully!"
        redirect_to "/menu_admin"
      else
        flash[:error] = category.errors.full_messages.join(", ")
        redirect_to request.referrer
      end
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
