module MoviesHelper

  def is_favorite(movie)
    if FavoriteMovie.where(user_id: current_user.id, movie_id: movie.id).any?
      return true
    end
    false
  end

end
