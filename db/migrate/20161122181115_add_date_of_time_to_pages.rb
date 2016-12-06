class AddDateOfTimeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :dateOfTime, :date
    add_column :pages, :department, :string
  end
end
