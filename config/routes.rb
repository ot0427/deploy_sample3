Rails.application.routes.draw do
  
  devise_for :users

  
  resources :goals
  resources :posts

  
  get "up" => "rails/health#show", as: :rails_health_check

  
  root 'goals#index'
end
