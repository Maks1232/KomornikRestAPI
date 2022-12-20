class CreateUsergroups < ActiveRecord::Migration[7.0]
  def change
    create_table :usergroups do |t|

      t.timestamps
    end
  end
end
