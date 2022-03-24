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

  def get_image(width, height)
    unless image.attached?
        file_path = Rails.root.join('app/assets/images/greater-rhea-3668046_1280.jpeg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end



end
