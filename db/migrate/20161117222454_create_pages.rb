class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      #case modified
      t.string :credit_union
      t.string :activity
      t.string :task
      t.string :billing_options
      t.string :sun_notes
      t.string :mon_notes
      t.string :tue_notes
      t.string :wed_notes
      t.string :thu_notes
      t.string :fri_notes
      t.string :sat_notes
      t.float :sun
      t.float :mon
      t.float :tue
      t.float :wed
      t.float :thu
      t.float :fri
      t.float :sat
      t.float :total
      t.string :approval
      t.date :date_of_time
      t.string :department
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :pages, [:user_id, :created_at]
  end
end
