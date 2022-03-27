class Customer < ApplicationRecord
  has_many :orders
  has_many :addresses
  has_many :cart_items

  validates :family_name, presence:true
  validates :first_name, presence:true
  validates :family_name_kana, presence:true
  validates :first_name_kana, presence:true
  validates :email, presence:true
  validates :post_code, presence:true
  validates :address, presence:true
  validates :telephone, presence:true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end