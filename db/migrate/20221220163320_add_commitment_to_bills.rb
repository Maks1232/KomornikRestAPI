class AddCommitmentToBills < ActiveRecord::Migration[7.0]
  def change
    add_reference :bills, :commitment, null: false, foreign_key: true
  end
end
