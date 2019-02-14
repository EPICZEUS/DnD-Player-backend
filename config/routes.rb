Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'rails/c'
    end
  end
  namespace :api do
    namespace :v1 do
      mount ActionCable.server => '/cable'

      get "/login", to: "auth#create"
      get "/retrieve", to: "users#retrieve"

      post "/register", to: "users#create"

      resources :campaigns do
        resources :encounters, controller: "campaigns/encounters"
        resources :messages, controller: "campaigns/messages"
      end
      resources :campaign_channels
      resources :characters do 
        patch '/positions/:id', to: "characters#adjust_position"
        delete '/positions/:id', to: "characters#delete_position"
      end
      resources :creatures do 
        patch '/positions/:id', to: "creatures#adjust_position"
        delete '/positions/:id', to: "creatures#delete_position"
      end
      resources :dm_channels
      resources :messages
      resources :users
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
