module MoviesHelper

  def is_favorite(movie)
    if FavoriteMovie.where(user_id: current_user.id, movie_id: movie.id).any?
      return true
    end
    false
  end

  def avg_rating(movie)
    avg = 0.0
    count = 0
    if movie&.reviews
      movie.reviews.each { |review|
        avg = avg + review.score
        count+=1
      }
      if count != 0
        avg = avg/count
      end
    end
    avg.round(2)
  end

end
