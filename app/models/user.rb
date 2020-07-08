class User < ApplicationRecord
  mount_uploader :avter, ImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :email, :first_name, :first_name_kana, :last_name, :last_name_kana, :birthday, presence: true
  validates_format_of :password, :with => /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/, :message => "は７文字以上の英数混在で入力してください"
  validates_format_of :first_name, :last_name, :with => /\A[ぁ-んァ-ン一-龥]/, :message => "は全角で入力してください"
  validates_format_of :first_name_kana, :last_name_kana, :with => /\A[ァ-ヶー－]+\z/, :message => "は全角カタカナで入力してください"
  has_one :address
  has_one :cards, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_items, through: :likes, source: :item

  def already_liked?(item)
    likes.exists?(item_id: item.id)
  end


end
