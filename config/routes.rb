Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :maps, only: [:index, :show, :new, :create] do
    resources :memberships, only: [:create]
    resources :pins, only: [:create]
  end
  resources :places, only: [:show] do
    resources :reviews, only: [:create]
  end
  resources :reviews, only: [:update]
  resources :users, only: [:show]
  resources :pins, only: [:destroy]
  namespace :owner do
    resources :maps, only: :index
  end
end
