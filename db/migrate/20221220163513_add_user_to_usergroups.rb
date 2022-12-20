class AddUserToUsergroups < ActiveRecord::Migration[7.0]
  def change
    add_reference :usergroups, :user, null: false, foreign_key: true
  end
end
