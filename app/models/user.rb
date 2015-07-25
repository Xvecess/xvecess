class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :votes, dependent: :destroy
  has_many :comments
  has_many :authorizations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  enum status: {guest: 0, confirmed_user: 1, admin: 99 }

  def voted?(votable)
    votes.where(votable: votable).first ? true : false
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email] unless auth.info.blank?
    user = User.where(email: email).first
    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create(email: email, password: password, password_confirmation: password)
      user.skip_confirmation! if auth.provider == 'facebook'
      return nil unless user.save
      user.create_authorization(auth)
    end
    user
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
