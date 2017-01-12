class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      #case modified
      t.string :credit_union
      t.string :activity
      t.string :task
      t.string :billing_options
      t.string :billing_options_scr
      t.string :billing_options_ftr
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
