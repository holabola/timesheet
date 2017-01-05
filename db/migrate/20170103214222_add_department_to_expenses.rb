class AddDepartmentToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :department, :string
  end
end
