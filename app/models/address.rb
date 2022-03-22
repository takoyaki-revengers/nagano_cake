class Address < ApplicationRecord
  belongs_to :customer

  def full_address #注文情報入力画面のお届け先表示用
    '〒' + post_code + ' ' + address + ' ' + name
  end

end
