class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :like, dependent: :destroy
  has_one :image, dependent: :destroy
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :postage
  belongs_to_active_hash :shippingday
  belongs_to_active_hash :shippingmethod
end