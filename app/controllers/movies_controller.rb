class MoviesController < ApplicationController
  before_action :require_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  CACHE_EXPIRY = Rails.application.config.cache_config[:cache_expiry]
  MOVIES_LIST_CACHE = Rails.application.config.cache_config[:MOVIES_LIST]


  def index
    puts MOVIES_LIST_CACHE, CACHE_EXPIRY
    @movies = fetchAllMovies
    # @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      invalidate_cache(MOVIES_LIST_CACHE)
      redirect_to movies_path, notice: "Movie created successfully"
    else
      render :new
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    invalidate_cache(MOVIES_LIST_CACHE)
    redirect_to movies_path, notice: "Movie deleted successfully"
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :language, :release_date)
  end
end
