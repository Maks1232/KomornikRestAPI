class AddGroupinfoToCommitments < ActiveRecord::Migration[7.0]
  def change
    add_reference :commitments, :groupinfo, null: false, foreign_key: true
  end
end
