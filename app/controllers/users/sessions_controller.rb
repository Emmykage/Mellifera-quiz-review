# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  respond_to :json


  def create
      if params[:user][:email].present?
        user = User.find_by(email: params[:user][:email])
      end

      if user.nil? && params[:user][:screen_name].present?
        user = User.find_by(screen_name: params[:user][:screen_name])
      end



    if user&.valid_password?(params[:user][:password])
      sign_in(user)
      respond_with(user)
    else
      render json: {
        status: {
          code: 401,
          message: 'Invalid screen name/email or password.'
        }
      }, status: :unauthorized
    end
  end



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
