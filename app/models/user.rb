class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    clean_up_passwords
    update_attributes(params, *options)
  end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :email, :first_name, :first_name_kana, :last_name, :last_name_kana, :birthday, presence: true
  validates_format_of :password, :with => /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/, :message => "は７文字以上の英数混在で入力してください"
  validates_format_of :first_name, :last_name, :with => /\A[一-龥ぁ-ん]/, :message => "は全角で入力してください"
  validates_format_of :first_name_kana, :last_name_kana, :with => /\A[ァ-ヶー－]+\z/, :message => "は全角カタカナで入力してください"
  has_one :address



end