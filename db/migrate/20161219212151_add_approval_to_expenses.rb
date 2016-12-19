class AddApprovalToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :approval, :string
  end
end
