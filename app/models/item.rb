class Item < ApplicationRecord
  has_one_attached :image

  has_many :order_details
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  #emum
  enum sales_status: { on_sale: 0, stopping_sales: 1 }

 #税込価格
 def  add_tax_price
  (self.price * 1.10).round
 end



end
