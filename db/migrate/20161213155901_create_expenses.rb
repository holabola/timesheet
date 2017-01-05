class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :creditUnion
      t.date :dateActivity
      t.string :type
      t.float :amount
      t.string :payment
      t.string :notes
      t.string :filename
      t.string :content_type
      t.binary :file_contents
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end