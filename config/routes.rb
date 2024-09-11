Rails.application.routes.draw do
  resources :responses
  resources :reviews
  resources :room_beds
  resources :room_services
  resources :beds
  resources :services
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users
  resources :rooms do
    collection do
      get 'search'
    end
  end
  resources :reservations do
    member do
      patch :cancel
      patch :check_in
      patch :check_out
      patch :no_show
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root to: "rooms#search"

end
