class User < ApplicationRecord
  has_many :products
  has_many :orders
  before_save { email.downcase! }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable,
         :authentication_keys => [:email]

  validates :username,  presence: true, length: { minimum: 3, maximum: 50 }

  def self.generate_authentication_token!
    BCrypt::Password.create(SecureRandom.urlsafe_base64)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:email)
      where(conditions).where("lower(email) = :value", { :value => login.downcase }).first
    elsif
      where(conditions).first
    end
  end

end
