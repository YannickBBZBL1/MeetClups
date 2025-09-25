Rails.application.routes.draw do
  get "activities/index"
  get "users/show"
  get "users/edit"
  get "users/update"
  get "accounts/show"
  get "accounts/edit"
  get "accounts/update"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resource :registrations, only: [:new, :create], path: "register"
  resource :user, only: [:show, :edit, :update]
  resource :session
  resources :clubs
  resources :meetups

  resources :clubs do
    member do
      post :join
    end

    resources :meetups, only: [:index, :show, :new, :create, :edit, :destroy, :update] do
      member do
        post :participate
      end
    end
  end

  namespace :admin do
    resources :users, only: [:index, :edit, :update]
  end

  resources :activities, only: [:index]



  # Defines the root path route ("/")
  root "clubs#index"
end
