Rails.application.routes.draw do
  resources :questions

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

    patch 'users/:id', to: 'users/registrations#update', as: :update_user
    get 'users/:id', to: 'users/registrations#show', as: :get_user
    post 'users/refresh', to: 'users/sessions#refresh', as: :get_refreh


    get 'users/:id/inbox', to: 'users/registrations#inbox', as: :get_inbox
  end

  post 'users/:id/inbox', to: 'messages#send_message', as: :send_message


  get "up" => "rails/health#show", as: :rails_health_check


  root "questions#index"


end
