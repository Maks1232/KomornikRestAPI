class AddIspaidToBills < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :ispaid, :boolean, default: 0
  end
end
