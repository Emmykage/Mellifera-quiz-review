# app/controllers/users/omniauth_callbacks_controller.rb

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google
      handle_auth "Google"
    end

    def twitter
      handle_auth "Twitter"
    end

    private

    def handle_auth(kind)

      # binding.b

      @user = User.from_omniauth(request.env['omniauth.auth'])
      # binding.b
      if @user.persisted?
        token = @user.generate_jwt
        render json: {
          message: "#{kind} login successful",
          token: token,
          user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
        }, status: :ok
      else
        render json: { error: @user.errors.full_messages.join("\n") }, status: :unprocessable_entity
      end
    end
  end
