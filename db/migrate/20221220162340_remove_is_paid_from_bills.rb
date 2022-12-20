class RemoveIsPaidFromBills < ActiveRecord::Migration[7.0]
  def change
    remove_column :bills, :ispaid, :string
  end
end
