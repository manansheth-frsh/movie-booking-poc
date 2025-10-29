class ApplicationController < ActionController::Base
  include Pagy::Backend
  CACHE_EXPIRY = Rails.application.config.cache_config[:cache_expiry]
  THEATRE_LIST_CACHE = Rails.application.config.cache_config[:THEATRE_LIST]
  MOVIES_LIST_CACHE = Rails.application.config.cache_config[:MOVIES_LIST]
  private

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
