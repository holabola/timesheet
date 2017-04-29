class ChangeImageToJson < ActiveRecord::Migration[5.0]
  def change
    remove_column :expenses, :image
    add_column :expenses, :image, :json
  end
end
