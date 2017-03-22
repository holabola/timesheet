class AddSubmittedToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :submitted, :string
    add_column :expenses, :approvalFinal, :string
  end
end
