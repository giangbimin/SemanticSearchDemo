Rails.application.routes.draw do
  resources :articles
  root "articles#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
