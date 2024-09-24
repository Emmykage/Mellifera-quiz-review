Rails.application.routes.draw do

  resources :messages, only: %i[index create]

  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: 'logout',
    registration: 'signup',
     edit: 'edit_user'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'auth/google_oauth2/callback', to: 'users/omniauth_callbacks#google'
    get 'auth/twitter/callback', to: 'users/omniauth_callbacks#twitter'

    put 'users', to: 'users/registrations#update', as: :update_user
    get 'users', to: 'users/registrations#show', as: :get_user
  end

  get "up" => "rails/health#show", as: :rails_health_check


end
