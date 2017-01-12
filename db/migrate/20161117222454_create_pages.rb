class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      #case modified
      t.string :creditunion
      t.string :activity
      t.string :task
      t.string :billingoptions
      t.string :billingoptionsscr
      t.string :billingoptionsftr
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
