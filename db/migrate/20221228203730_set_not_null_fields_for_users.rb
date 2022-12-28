class SetNotNullFieldsForUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :login, :string, null: false
    change_column :users, :password, :string, null: false
    change_column :users, :mail, :string, null: false
  end
end
