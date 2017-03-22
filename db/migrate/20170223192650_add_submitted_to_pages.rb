class AddSubmittedToPages < ActiveRecord::Migration
  def change
    add_column :pages, :submitted, :string
  end
end
