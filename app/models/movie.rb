class Movie < ApplicationRecord
  has_many :favorite_movies, dependent: :destroy
  has_many :favorited_by, through: :favorite_movies, source: :user
  has_many :roles, dependent: :destroy
  has_many :acted_in_by, through: :roles, source: :actor
  has_many :reviews, dependent: :destroy

  has_one :director, dependent: :destroy
  has_one :directed_by, through: :director, source: :actor

  has_one_attached :thumbnail
  has_one_attached :banner

  has_rich_text :description

  validates :title, length: { minimum: 1 }
  validates :description, length: { minimum: 24 }
  validates_date :release_date
  validates :duration, presence: true

  validates :thumbnail, attached: true, content_type: %w[image/png image/jpg image/jpeg]
  validates :banner, attached: true, content_type: %w[image/png image/jpg image/jpeg]

  self.per_page = 8
  extend FriendlyId
  friendly_id :title, use: :slugged

  def optimized_image(image,x,y)
    image.variant(resize_to_fill: [x, y]).processed
  end

  def self.search(search)
    if search
      if search.kind_of? String and !search.to_s.empty?
        self.where('title like ?', "%#{ search }%")
      else
        Movie.all
      end
    else
      Movie.all
    end
  end

end
