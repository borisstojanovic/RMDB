class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def username
    email.split("@")[0].capitalize
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end
end
