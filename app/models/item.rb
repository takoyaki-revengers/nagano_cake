class Item < ApplicationRecord
  has_one_attached :image

  has_many :order_details
  belongs_to :genre
  has_many :cart_items, dependent: :destroy

  #emumの定義
  enum is_active: { on_sale: 0, stop: 1 }


 #税込価格
 def  add_tax_price
  (self.price * 1.10).round
 end

def get_image(width, height)
  image.variant(resize_to_limit: [width, height]).processed
end



end
