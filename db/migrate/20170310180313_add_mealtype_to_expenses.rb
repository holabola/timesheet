class AddMealtypeToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :meal_type, :string
  end
end
