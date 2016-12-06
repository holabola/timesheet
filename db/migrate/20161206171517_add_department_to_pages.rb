class AddDepartmentToPages < ActiveRecord::Migration
  def change
    add_column :pages, :department, :string
  end
end
