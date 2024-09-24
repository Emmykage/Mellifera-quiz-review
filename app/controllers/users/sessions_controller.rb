# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # include RackSessionsFix
  respond_to :json


  private
  def respond_with(current_user, _opts = {})

  token = request.env['warden-jwt_auth.token']


    render json: {
      status: {
        code: 200, message: 'Logged in successfully.',
        data: current_user,
        token: token
      },

    }, status: :ok
  end
  def respond_to_on_destroy
    if request.headers['Authorization'].present?

      binding.b
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.secret_key_base).first
      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

end
