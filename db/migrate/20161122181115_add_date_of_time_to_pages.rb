class AddDateOfTimeToPages < ActiveRecord::Migration
  def change
    #case modified
    add_column :pages, :dateoftime, :date
    add_column :pages, :department, :string
  end
end
