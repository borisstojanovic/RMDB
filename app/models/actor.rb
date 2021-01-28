class Actor < ApplicationRecord
  has_many :roles
  has_many :acted_in, through: :roles, source: :movie

  validates :firstname, length: { minimum: 1 }
  validates :lastname, length: { minimum: 1 }
  validates_date :date_of_birth, timeliness: {on_or_after: lambda { Date.current }, type: :date}
  validates :bio, length: {minimum: 24}

  validate :past_date



  def past_date
    if date_of_birth >= Date.current
      self.errors.add(:date_of_birth, "must be a past date / time")
    end
  end

  def has_acted(movie)
    puts(self.acted_in)
    if movie.in?(self.acted_in)
      return true
    end
    false
  end

end
