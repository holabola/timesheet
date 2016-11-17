class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :creditUnion
      t.string :activity
      t.string :task
      t.string :billingOptions
      t.string :billingOptionsSCR
      t.string :billingOptionsFTR
      t.integer :sun
      t.integer :mon
      t.integer :tue
      t.integer :wed
      t.integer :thu
      t.integer :fri
      t.integer :sat
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :pages, [:user_id, :created_at]
  end
end
