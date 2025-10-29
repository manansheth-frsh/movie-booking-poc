require 'pagy/extras/bootstrap'  # for Bootstrap pagination UI
class BookingsController < ApplicationController
  include AccessConcern
  include Pagy::Backend
  before_action :require_login_alias
  
  CACHE_EXPIRY = Rails.application.config.cache_config[:cache_expiry]
  SHOWS_AVAILABLE = Rails.application.config.cache_config[:SHOWS_AVAILABLE]
  def new
    @movies = fetchAllMovies
    @theatres = fetchAllTheatres

    @selected_movie = params[:movie_id].present? ? Movie.find_by(id: params[:movie_id]) : nil
    @selected_theatre = params[:theatre_id].present? ? Theatre.find_by(id: params[:theatre_id]) : nil

    if @selected_movie
      @shows = Show.includes(:theatre).where(movie: @selected_movie).order(date: :desc, slot: :asc)
    elsif @selected_theatre
      @shows = Show.includes(:movie).where(theatre: @selected_theatre).order(date: :desc, slot: :asc)
    else
      @shows = []
    end
  end

  def create
    show = Show.find(params[:show_id])
    seats_to_book = params[:seats].to_i

    if seats_to_book <= 0
      redirect_back fallback_location: new_booking_path, alert: "Number of seats must be at least 1"
      return
    end

    if seats_to_book > show.current_available_bookings
      redirect_back fallback_location: new_booking_path, alert: "Cannot book more than #{show.current_available_bookings} seats"
      return
    end

    # Create booking
    Rails.logger.info "Current user: #{current_user.inspect}"
    Rails.logger.info "Show: #{show.inspect}"
    Rails.logger.info "Seats to book: #{seats_to_book}"

    booking = Booking.create!(
      user: current_user,
      show: show,
      seats: seats_to_book
    )

    # Reduce available seats
    show.update!(current_available_bookings: show.current_available_bookings - seats_to_book)
    redirect_to bookings_path, notice: "Booking confirmed for #{seats_to_book} seats"
  end

  def index
    Rails.logger.info "Pagy items param: 5"
    @pagy, @bookings = pagy(
      current_user.bookings.includes(show: [:movie, :theatre])
      .order('shows.date ASC')
      .references(:show),
      items: 5
    )
  end

end
