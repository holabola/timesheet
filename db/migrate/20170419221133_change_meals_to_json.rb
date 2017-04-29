class ChangeMealsToJson < ActiveRecord::Migration[5.0]
  def change
    remove_column :expenses, :meal_names
    add_column :expenses, :meal_names, :json
    remove_column :expenses, :meals
    add_column :expenses, :meals, :json
  end
end
