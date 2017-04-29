class ApprovalFinalChangeCapital < ActiveRecord::Migration
  def change
    rename_column :expenses, :approvalFinal, :approval_final
  end
end
