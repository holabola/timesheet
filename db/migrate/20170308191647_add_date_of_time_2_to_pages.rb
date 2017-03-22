class AddDateOfTime2ToPages < ActiveRecord::Migration
  def change
    add_column :pages, :date_of_time_2, :date
  end
end
