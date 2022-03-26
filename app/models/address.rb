class Address < ApplicationRecord
  belongs_to :customer

  validates :name, presence:true
  validates :post_code, presence:true
  validates :address, presence:true

  def full_address #注文情報入力画面のお届け先表示用
    '〒' + post_code + ' ' + address + ' ' + name
  end

end
