class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorite_movies ,dependent: :destroy
  has_many :favorites, through: :favorite_movies, source: :movie
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :helpfuls, dependent: :destroy
  has_many :helpful_reviews, through: :helpfuls, source: :review

  self.per_page = 8

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

  def self.search_user(search)
    if search
      if search.kind_of? String and !search.to_s.empty?
        self.where('email like ?', "%#{search}%")
      else
        User.all
      end
    else
      User.all
    end
  end
end
