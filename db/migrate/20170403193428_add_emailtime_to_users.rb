class AddEmailtimeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lastemailed, :date
  end
end
