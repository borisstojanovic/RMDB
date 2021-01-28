class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :helpfuls, dependent: :destroy

  has_rich_text :body

  validates :body, length: { minimum: 24 }, presence: true

end
