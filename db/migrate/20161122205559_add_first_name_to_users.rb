class AddFirstNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :department, :string
    add_column :users, :admin, :boolean, default: false
  end
end
