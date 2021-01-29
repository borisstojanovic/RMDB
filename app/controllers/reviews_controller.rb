class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy, :helpful]
  before_action :set_movie
  before_action :authenticate_user!, except: [:show]


  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.movie = @movie
    if @review.score
    else
      @review.score = 0
    end
    respond_to do |format|
      if @review.save
        format.html { redirect_to movie_path(@movie), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: movie_path(@review.movie) }
      else
        format.html { render :new, notice: @review.errors, method: :get }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @review = Review.new
    @review.movie = @movie
  end

  def edit; end

  def show
    @comments = @review.comments.order('created_at DESC')
    @num_comments = @review.comments.count
    @review.comments.each do |comment|
      @num_comments += comment.comments.count
    end
  end

  def update
    @review.movie = @movie
    @review.user = current_user
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to movie_path(@movie) }
        format.json { render :show, status: :ok, location: movie_path(@movie) }
      else
        format.html { redirect_to edit_movie_review_path(@movie, id: @review), notice: @review.errors, method: :get }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    movie = @review.movie
    @review.destroy
    respond_to do |format|
      format.html { redirect_to movie_path(movie), notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def helpful
    type = params[:type]
    if type == "helpful"
      helpful = Helpful.where(user_id: current_user.id, review_id: @review.id)
      if helpful.any?
        helpful.update(is_helpful:type)
      else
        helpful = Helpful.new
        helpful.user_id = current_user.id
        helpful.review_id = @review.id
        helpful.is_helpful = type
        helpful.save
      end
      redirect_to movie_url(@movie), notice: "Review marked as helpful"

    elsif type == "unhelpful"
      helpful = Helpful.where(user_id: current_user.id, review_id: @review.id)
      if helpful.any?
        helpful.update(is_helpful:type)
      else
        helpful = Helpful.new
        helpful.user_id = current_user.id
        helpful.review_id = @review.id
        helpful.is_helpful = type
        helpful.save
      end
      redirect_to movie_url(@movie), notice: "Review marked as unhelpful"
    else
      # Type missing, nothing happens
      redirect_to movie_url(@movie), notice: 'Nothing happened.'
    end
  end

  private
  def review_params
    params.require(:review).permit(:body, :score)
  end

  def set_review
    begin
      @review = Review.find(params[:id])
    rescue => e
      redirect_back fallback_location: root_path
    end
  end

  def set_movie
    begin
      @movie = Movie.friendly.find(params[:movie_id])
    rescue => e
      redirect_back fallback_location: root_path
    end
  end

end
