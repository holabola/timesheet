class AddApprovalToPages < ActiveRecord::Migration
  def change
    add_column :pages, :approval, :string
  end
end
