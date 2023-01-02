Rails.application.routes.draw do
  resources :commitments
  resources :groupinfos
  resources :bills
  resources :users

  post "/login", to: "users#login"


  # Tworzenie nowej grupy
  post '/groupinfos', to: 'groupinfos#create'
  # Dodawanie użytkownika do grupy o danym ID
  post '/groupinfos/:id/users/:user_id', to: 'groupinfos#add_user'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
