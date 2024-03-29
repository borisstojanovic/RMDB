class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy role direct ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_authorized!, except: [:index, :show, :favorite, :favorites]

  # GET /movies or /movies.json
  def index
    @movies = Movie.search(params[:search]).order('created_at DESC').paginate(page: params[:page])
  end

  # GET /movies/1 or /movies/1.json
  def show
    views = @movie.views + 1
    @movie.update(views: views)
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
    @num_reviews = @movie.reviews.count
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def favorites
    @movies = Movie.search(params[:search]).order('created_at DESC')

    movies = []
    @movies.each { |movie|
      if helpers.is_favorite(movie)
        movies.append(movie.id)
      end
    }
    @movies = Movie.friendly.find(movies).paginate(page: params[:page])
  end

  # Set favorite movie for current user
  def favorite
    @movie = Movie.find(params[:movie])
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @movie
      redirect_back fallback_location: root_path, notice: "You favorited #{@movie.title}"

    elsif type == "unfavorite"
      current_user.favorites.delete(@movie)
      redirect_back fallback_location: root_path, notice: "Unfavorited #{@movie.title}"

    else
      # Type missing, nothing happens
      redirect_back fallback_location: root_path, notice: 'Nothing happened.'
    end
  end

  #add role to movie
  def role
    actor = Actor.find(params[:actor])
    @movie.acted_in_by << actor
    redirect_to movie_url(@movie), notice: "Added Role Successfully"
  end

  #add director to movie
  def direct
    actor = Actor.find(params[:actor])
    @movie.directed_by = actor
    @movie.save
    redirect_to movie_url(@movie), notice: "Added Director Successfully"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      begin
        @movie = Movie.friendly.find(params[:id])
      rescue => e
        redirect_back fallback_location: root_path
      end

    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:release_date, :title, :views, :description, :thumbnail, :banner, :duration)
    end

end
