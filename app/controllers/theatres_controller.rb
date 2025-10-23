class TheatresController < ApplicationController
  before_action :require_admin, only: [:index, :new, :create, :edit, :update, :destroy]

  CACHE_EXPIRY = Rails.application.config.cache_config[:cache_expiry]
  THEATRE_LIST_CACHE = Rails.application.config.cache_config[:THEATRE_LIST]

  def index
    @theatres = fetchAllTheatres
    # @theatres = Theatre.all
  end

  def show
  end

  def create
    @theatre = Theatre.new(theatre_params)
    if @theatre.save
      invalidate_cache(THEATRE_LIST_CACHE)
      redirect_to theatres_path, notice: "Theatre created successfully"
    else
      render :new
    end
  end

  def destroy
    @theatre = Theatre.find(params[:id])
    @theatre.destroy
    invalidate_cache(THEATRE_LIST_CACHE)
    redirect_to theatres_path, notice: "Theatre deleted successfully"
  end

  def update
  end

  def new
    @theatre = Theatre.new  # ✅ This is required
  end


  private
  def theatre_params
    params.require(:theatre).permit(:name, :city, :capacity)
  end

end
