Rails.application.routes.draw do
  devise_for :users

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  resources :employees do
    post :import_from_api, on: :collection
  end

  root 'employees#index'
  
  namespace :api do
    namespace :v1 do
      resources :employees
    end
  end
end
