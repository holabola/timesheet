class RenameImageExpenses < ActiveRecord::Migration[5.0]
  def change
    rename_column :expenses, :image, :images
  end
end
