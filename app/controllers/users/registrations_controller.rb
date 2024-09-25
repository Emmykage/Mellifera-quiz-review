class Users::RegistrationsController < Devise::RegistrationsController
  # include RackSessionsFix
  respond_to :json


  def inbox
    messages = Message.where(recipient: params[:id])

    if messages.any?
      render json: {
        status: {
          code: 200,
          message: "Messages retrieved successfully"
        },
        data: messages
      }, status: :ok
    else
      render json: {
        status: {
          code: 404,
          message: "No messages found"
        },
        data: []
      }, status: :not_found
    end
  end



def show

  # user = current_user
  user = User.find(params[:id])

  if user
    render json: {
      status: {
        code: 200,
        message: "User fetched successfully"
      },
      data: user_data(user)
    }, status: :ok
  else
    render json: {
      status: {
        code: 404,
        message: "User not found"
      }
    }, status: :not_found
  end
end



  def update

    self.resource = User.find(params[:id])

    if resource.update(user_update_params)

      resource.image.attach(params[:user][:image]) if params[:user][:image].present?

      render json: {
        status: {
          code: 200,
          message: "Profile updated successfully"
        },
        data: resource
      }, status: :ok
    else
      render json: {
        status: {
          message: "Profile couldn't be updated.",
          errors: resource.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end

  private

  def respond_with(current_user, _opt = {})
    if resource.persisted?
      render json: {
        status: {
          code: 200,
          message: "Signed up successfully"
        },
        data: resource
      }
    else
      render json: {
        status: {
          message: "User couldn't be created successfully.",
          errors: resource.errors.full_messages
        }
      }, status: :unprocessable_entity
    end
  end



  def user_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :image, :screen_name)
  end

  def user_data(user)
    {
      id: user.id,
      email: user.email,
      screen_name: user.screen_name,
      image_url: user.image_url # Include the image_url here
    }

  end
end
