class ApplicationController < ActionController::Base
  SECRET_KEY = Rails.application.credentials.jwt_secret_key

  CACHE_EXPIRY = Rails.application.config.cache_config[:cache_expiry]
  THEATRE_LIST_CACHE = Rails.application.config.cache_config[:THEATRE_LIST]
  MOVIES_LIST_CACHE = Rails.application.config.cache_config[:MOVIES_LIST]

  private

  # Decode JWT from raw token
  def decode_token(token)
    begin
      decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
      decoded[0]   # Returns payload as hash
    rescue JWT::ExpiredSignature
      nil         # Token expired
    rescue JWT::DecodeError
      nil         # Invalid token
    end
  end

  # Require admin for protected actions
  def require_admin
    token = cookies[:jwt]           # raw JWT
    payload = decode_token(token)
    if payload.nil? || payload['is_admin'] != true
      render json: { error: "Forbidden" }, status: :forbidden
    end
  end

  # Require user to be logged in (optional)
  def require_login
    token = cookies[:jwt]
    payload = decode_token(token)
    render json: { error: "Unauthorized" }, status: :unauthorized if payload.nil?
  end

  def current_user
    return @current_user if defined?(@current_user)

    token = cookies[:jwt]           # raw JWT
    payload = decode_token(token)
    puts "token is ",payload
    return nil unless token

    payload = decode_token(token)
    @current_user = User.find_by(id: payload["user_id"]) if payload
  end

  def invalidate_cache(cache_key="")
    Rails.cache.delete(cache_key)
    puts "cache invaidated"
  end

  def fetchAllMovies
    return Rails.cache.fetch(MOVIES_LIST_CACHE, expires_in: CACHE_EXPIRY) do
      Movie.all.to_a
    end
  end

  def fetchAllTheatres
    @theatres = Rails.cache.fetch(THEATRE_LIST_CACHE, expires_in: CACHE_EXPIRY) do
      Theatre.all.to_a
    end
  end


end
