class DeleteDateFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :date_of_time_2, :date
    change_column :pages, :date_of_time, 'date USING CAST(date_of_time AS date)'
  end
end
