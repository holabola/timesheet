class ChangeColumnNameExpense < ActiveRecord::Migration
  def change
    #case modified
    rename_column :expenses, :type, :typeofexpense
    add_column :expenses, :image, :string
  end
end
