class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :firstname, limit: 32
      t.string :lastname, limit: 32
      t.string :login, limit: 15
      t.string :password, limit: 32
      t.string :mail, limit: 32

      t.timestamps
    end
  end
end
