Rails.application.routes.draw do
  resources :usergroups
  resources :commitments
  resources :groupinfos
  resources :bills
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
