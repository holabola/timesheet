class AddDateOfTimeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :dateOfTime, :date
  end
end
