class AddStatusToMenuCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_categories, :status, :string
  end
end
