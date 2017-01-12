class AddFirstNameToUsers < ActiveRecord::Migration
  def change
    #case modified
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :department, :string
    add_column :users, :admin, :boolean, default: false
  end
end
