Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do

      resources :goals, only: [:index, :show, :create, :update, :destroy]
      resources :users, only: [:show, :create, :update, :destroy]
      resource :sessions, only: [:create, :destroy]
      get '/current_user', to: "sessions#current"
      
    end
    match "*unmatched_route", to:"application#not_found", via: :all
  end

end
