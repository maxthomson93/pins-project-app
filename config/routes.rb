Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :pins, only: [:create]
  resources :maps, only: [:index, :show, :new, :create] do
    resources :memberships, only: [:create]
    resources :pins, only: [:create]
  end
  resources :places, only: [:show] do
    resources :reviews, only: [:create]
    member do
      post 'upvote'
    end
    collection do
      get :search
    end
  end
  resources :reviews, only: [:create]
  
  resources :users do
    member do
      get 'tags'
      patch 'tags'
    end
  end
  resources :pins, only: [:destroy]
  namespace :owner do
    resources :maps, only: :index
  end

end
