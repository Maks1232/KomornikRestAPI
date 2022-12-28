class CreateJoinTableGroupinfosUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :groupinfos, :users do |t|
       t.index [:groupinfo_id, :user_id]
       t.index [:user_id, :groupinfo_id]
    end
  end
end
