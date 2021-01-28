module ReviewsHelper
  def is_reviewer(review)
    if current_user
      if Review.where(user_id: current_user.id, id: review.id).any?
        return true
      end
    end
    false
  end

  def is_helpful(review)
    if current_user
      if Helpful.where(user_id: current_user.id, review_id: review.id, is_helpful: "helpful").any?
        return true
      end
    end
    false
  end

  def is_unhelpful(review)
    if current_user
      if Helpful.where(user_id: current_user.id, review_id: review.id, is_helpful: "unhelpful").any?
        return true
      end
    end
    false
  end

  def num_helpful(review)
    Helpful.where(review_id: review.id, is_helpful: "helpful").count
  end

  def num_unhelpful(review)
    Helpful.where(review_id: review.id, is_helpful: "unhelpful").count
  end

  def num_total(review)
    Helpful.where(review_id: review.id).count
  end
end
