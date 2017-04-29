class AddMealnamesToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :meal_names, :string
    add_column :expenses, :meal_total, :float
  end
end
