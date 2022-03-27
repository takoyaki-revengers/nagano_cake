class RenameOderDetailsToOrderDetails < ActiveRecord::Migration[6.1]
  def up
    rename_table :oder_details, :order_details
  end

  def down
    rename_table :order_details, :oder_details
  end
end
