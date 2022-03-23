class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum payment_method: { credit_card: 0, transfer: 1 } #enumで支払方法を定義（0：クレジット、1：銀行振込）


end
