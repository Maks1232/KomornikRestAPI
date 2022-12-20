class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.decimal :amount
      t.string :ispaid, limit: 3

      t.timestamps
    end
  end
end
