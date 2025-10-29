module AccessConcern
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.credentials.jwt_secret_key

  
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

  alias require_login_alias require_login
end
