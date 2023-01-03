class CreateCommitmentsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :commitments_users, id: false do |t|
      t.belongs_to :commitment, index: true
      t.belongs_to :user, index: true
    end
  end
end




