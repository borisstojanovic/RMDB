class Article < ApplicationRecord

  #cloudinary setup
  mount_uploader :thumbnail, AvatarUploader

  has_rich_text :body

  validates :title, length: { minimum: 1 }
  validates :body, length: { minimum: 24 }

  self.per_page = 6
  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.search_article(search)
    if search
      if search.kind_of? String and !search.to_s.empty?
        self.where('title like ?', "%#{ search }%")
      else
        Article.all
      end
    else
      Article.all
    end
  end

end
