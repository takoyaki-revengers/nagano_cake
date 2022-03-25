class Item < ApplicationRecord
  has_one_attached :image

  has_many :order_details
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  #emumの定義
 # enum is_active: { on_sale: 0, stop: 1 }

 validates :name, presence: true
 validates :introduction, presence: true
 validates :price, presence: true



 #税込価格
 def  add_tax_price
  (self.price * 1.10).round
 end

end
