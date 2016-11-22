class AddTotalToPages < ActiveRecord::Migration
  def change
    add_column :pages, :total, :integer
  end
end
