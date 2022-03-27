class RenameOdersToOrders < ActiveRecord::Migration[6.1]
  def up
    rename_table :oders, :orders
  end

  def down
    rename_table :orders, :oders
  end
end
