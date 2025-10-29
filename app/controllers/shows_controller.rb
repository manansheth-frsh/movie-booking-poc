class ShowsController < ApplicationController
  include AccessConcern
  before_action :require_admin

  def new
    @show = Show.new
    @movies = fetchAllMovies
    # @movies = Movie.all
    @theatres = fetchAllTheatres
    # @theatres = Theatre.all
  end

  def create
    @show = Show.new(show_params)
    if @show.save
        redirect_to shows_path, notice: "Show created successfully"
    else
      @movies = Movie.all
      @theatres = Theatre.all
      render :new
    end
  end

  def index
    @shows = Show.all.order(date: :asc)
  end

  def show
    puts "here..."
    @show = Show.find(params[:id])
    puts "show ->", @show.bookings
  end

  private


  def show_params
    params.require(:show).permit(:slot, :date, :movie_id, :theatre_id)
  end

end
