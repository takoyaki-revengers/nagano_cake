class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  # 小計
  def subtotal
    item.add_tax_price * amount
  end

  def total_payment
    item.add_tax_price * amount + 800
  end
end
