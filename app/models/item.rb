class Item < ApplicationRecord
  has_one_attached :image

  has_many :oder_detail
  # belongs_to :genre
  has_many :cart_items, dependemt: :destroy

end
