class ChangePaymentInExpenses < ActiveRecord::Migration
  def change
    remove_column :expenses, :payment
  end
end
