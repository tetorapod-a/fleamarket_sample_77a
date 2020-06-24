class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true
  belongs_to :categorie, optional: true
  has_many :comments, dependent: :destroy
  has_many :like, dependent: :destroy
  has_one :image, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :postage
  belongs_to_active_hash :shippingday
  belongs_to_active_hash :shippingmethod
end