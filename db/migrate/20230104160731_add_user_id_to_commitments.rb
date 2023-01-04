class AddUserIdToCommitments < ActiveRecord::Migration[7.0]
  def change
    add_reference :commitments, :user, null: false, foreign_key: true
  end
end
