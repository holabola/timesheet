class AddDateOfTimeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :dateoftime, :date
    add_column :pages, :department, :string
  end
end
