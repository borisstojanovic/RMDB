class Movie < ApplicationRecord
  has_many :favorite_movies
  has_many :favorited_by, through: :favorite_movies, source: :user

  has_one_attached :thumbnail
  has_one_attached :banner

  has_rich_text :description

  validates :title, length: { minimum: 1 }
  validates :description, length: { minimum: 24 }
  validates_date :release_date

  validates :thumbnail, attached: true, content_type: %w[image/png image/jpg image/jpeg]
  validates :banner, attached: true, content_type: %w[image/png image/jpg image/jpeg]

  self.per_page = 8

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
