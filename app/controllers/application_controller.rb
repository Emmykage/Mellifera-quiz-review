class ApplicationController < ActionController::API
    include CanCan::ControllerAdditions

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[screen_name])
        devise_parameter_sanitizer.permit(:account_update, keys: %i[screen_name])
    end


    rescue_from CanCan::AccessDenied do |exception|
        render json: { error: exception.message }, status: :forbidden
      end

end
