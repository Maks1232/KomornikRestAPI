class CreateJoinTableUserGroupinfo < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :groupinfos do |t|
      # t.index [:user_id, :groupinfo_id]
      # t.index [:groupinfo_id, :user_id]
    end
  end
end
