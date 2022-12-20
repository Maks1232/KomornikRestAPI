class AddGroupinfoToUsergroups < ActiveRecord::Migration[7.0]
  def change
    add_reference :usergroups, :groupinfo, null: false, foreign_key: true
  end
end
