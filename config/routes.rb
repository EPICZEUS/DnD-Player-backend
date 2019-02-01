Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount ActionCable.server => '/cable'

      get "/login", to: "auth#create"
      get "/retrieve", to: "users#retrieve"

      post "/register", to: "users#create"

      resources :campaigns do
        resources :encounters, controller: "campaigns/encounters"
      end
      resources :campaign_channels
      resources :characters
      resources :creatures
      resources :dm_channels
      resources :messages
      resources :users
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
