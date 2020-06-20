class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :first_name, :first_name_kana, :last_name, :last_name_kana, :postal_code,
            :prefectur, :city, :house_number, presence: true
  validates_format_of :first_name, :last_name, :prefectur, :city, :with => /\A[ぁ-んァ-ン一-龥]/, :message => "は全角で入力してください"
  validates_format_of :first_name_kana, :last_name_kana, :with => /\A[ァ-ヶー－]+\z/, :message => "は全角カタカナで入力してください"
  validates_format_of :postal_code, :with => /\A[0-9]+\z/, :message => "は半角数字で入力してください"
  validates_format_of :postal_code, :with => /\A\d{7}\z/, :message => "はハイフンなしの7桁で入力してください"
end