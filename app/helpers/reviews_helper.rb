module ReviewsHelper
  def is_reviewer(review)
    if Review.where(user_id: current_user.id, id: review.id).any?
      return true
    end
    false
  end
end
