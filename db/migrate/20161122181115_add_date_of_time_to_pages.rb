class AddDateOfTimeToPages < ActiveRecord::Migration
  def change
    #case modified
    add_column :pages, :date_of_time, :date
    add_column :pages, :department, :string
  end
end
