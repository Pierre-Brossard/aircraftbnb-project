Rails.application.routes.draw do
  devise_for :users
  root to: "aircrafts#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :aircrafts do
    resources :bookings, only: [:new, :create]
  end

  resources :users, only: :show
  resources :bookings, only: [:update]
  patch '/bookings/:id/confirm', to: "bookings#confirm", as: :confirm_booking
  patch '/bookings/:id/deny', to: "bookings#deny", as: :deny_booking

end
