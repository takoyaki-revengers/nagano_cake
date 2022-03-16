class CreateOders < ActiveRecord::Migration[6.1]
  def change
    create_table :oders do |t|
      t.integer :customer_id, null:false
      t.string :post_code, null:false
      t.string :address, null:false
      t.string :name, null:false
      t.integer :shipping_cost, null:false
      t.integer :total_payment, null:false
      t.integer :payment_method, null:false, default: "0"
      t.integer :status, null:false, default: ""
      t.timestamps
    end
  end
end
