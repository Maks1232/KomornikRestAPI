class CreateGroupinfos < ActiveRecord::Migration[7.0]
  def change
    create_table :groupinfos do |t|
      t.string :groupname, limit: 20

      t.timestamps
    end
  end
end
