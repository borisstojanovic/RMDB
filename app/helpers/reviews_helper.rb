module ReviewsHelper
  def is_reviewer(review)
    if current_user
      if Review.where(user_id: current_user.id, id: review.id).any?
        return true
      end
    end
    false
  end
end
