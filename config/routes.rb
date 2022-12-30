Rails.application.routes.draw do
  resources :commitments
  resources :groupinfos
  resources :bills
  resources :users, only: [:create, :destroy, :new, :index, :show, :update, :edit]
  post "/login", to: "users#login"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
