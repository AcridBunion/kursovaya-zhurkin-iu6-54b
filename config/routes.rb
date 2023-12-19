Rails.application.routes.draw do
  get 'find_autos/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'autos#index'
  # Defines the root path route ("/")
  resources :autos do
    resources :comments
  end

  resources :profiles

  resources :find_autos
end
