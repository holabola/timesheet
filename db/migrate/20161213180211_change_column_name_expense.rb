class ChangeColumnNameExpense < ActiveRecord::Migration
  def change
    #case modified
    rename_column :expenses, :type, :type_of_expense
    add_column :expenses, :image, :string
  end
end
