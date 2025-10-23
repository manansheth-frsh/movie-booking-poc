class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    # redirect_to theatres_path if cookies[:jwt].present? && decode_token(cookies[:jwt])
  end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      # Include is_admin in the token payload
      token = encode_token(user_id: user.id, is_admin: user.is_admin)

      cookies[:jwt] = {
        value: token,
        httponly: true,
        expires: 8.hours.from_now
      }
      if user.is_admin?
        redirect_to admin_path
      else
        redirect_to bookings_path
        end
      else
        render json: { error: 'Invalid Email or Password' }, status: :unauthorized
      end
    end

    private

    # Encode payload into JWT
    def encode_token(payload, exp = 8.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end
  end
