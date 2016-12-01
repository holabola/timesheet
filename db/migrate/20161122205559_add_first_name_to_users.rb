class AddFirstNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstName, :string
    add_column :users, :lastName, :string
    add_column :users, :department, :string
    add_column :users, :admin, :boolean, default: false
  end
end
