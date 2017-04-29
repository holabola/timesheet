class AddJobsToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :miles_traveled, :float
    add_column :expenses, :mileage_expense, :float
    add_column :expenses, :air_travel, :float
    add_column :expenses, :taxi_parking, :float
    add_column :expenses, :car_rental, :float
    add_column :expenses, :meals, :float
    add_column :expenses, :lodging, :float
    add_column :expenses, :entertainment, :float
    add_column :expenses, :other, :float
    add_column :expenses, :total, :float
    add_column :expenses, :job, :string
  end
end
