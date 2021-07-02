class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :state
      t.string :city
      t.string :address
      t.string :contact_no
      t.string :role
      t.string :password_digest

      t.timestamps
    end
  end
end
