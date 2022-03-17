class Oder < ApplicationRecord
  belongs_to :customer
  has_many :oder_details

end
