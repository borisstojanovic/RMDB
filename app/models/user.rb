class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorite_movies
  has_many :favorites, through: :favorite_movies, source: :movie
  has_many :comments, dependent: :destroy

  def username
    email.split("@")[0].capitalize
  end

  def comment_created
    self.number_of_comments = number_of_comments + 1
    save
    number_of_comments
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end
end
