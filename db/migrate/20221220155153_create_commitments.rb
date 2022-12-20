class CreateCommitments < ActiveRecord::Migration[7.0]
  def change
    create_table :commitments do |t|
      t.string :commitmentdesc, limit: 64
      t.decimal :commitmentamount
      t.date :occurancedate
      t.date :expirationdate

      t.timestamps
    end
  end
end
