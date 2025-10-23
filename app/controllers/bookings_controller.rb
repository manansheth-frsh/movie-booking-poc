class BookingsController < ApplicationController
  before_action :require_login

  CACHE_EXPIRY = Rails.application.config.cache_config[:cache_expiry]
  def new
     @movies = Rails.cache.fetch("movies_list", expires_in: CACHE_EXPIRY) do
      puts "Fetching movies from DB..."
      Movie.all.to_a
    end
    @theatres = Rails.cache.fetch("theatres_list", expires_in: CACHE_EXPIRY) do
      puts "Fetching theatre from DB..."
      Theatre.all.to_a
    end
    @theatres = Theatre.all
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
    @bookings = current_user.bookings.includes(:show => [:movie, :theatre]).order(created_at: :desc)
  end
end
