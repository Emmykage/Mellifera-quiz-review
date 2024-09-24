Rails.application.routes.draw do

  resources :messages, only: %i[index create]

  devise_for :users, path: "", path_names: {
    sign_in: "login",
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get "up" => "rails/health#show", as: :rails_health_check


end
