class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  validates :nickname, :email, :first_name, :first_name_kana, :last_name, :last_name_kana, :birthday, presence: true
  validates_format_of :password, :with => /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/, :message => "は７文字以上の英数混在で入力してください"
  validates_format_of :first_name, :last_name, :with => /\A[一-龥ぁ-ん]/, :message => "は全角で入力してください"
  validates_format_of :first_name_kana, :last_name_kana, :with => /\A[ァ-ヶー－]+\z/, :message => "は全角カタカナで入力してください"
  has_one :address

  has_one :credit_card, dependent: :destroy
  has_many :sns_credentials

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    user
  end
end
