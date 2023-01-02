Rails.application.routes.draw do
  resources :commitments
  resources :groupinfos
  resources :bills
  resources :users

  post "/login", to: "users#login"


  # Tworzenie nowej grupy
  post '/groupinfos', to: 'groupinfos#create'

  # Usuwanie grupy o danym ID
  delete '/groupinfos/:id', to: 'groupinfos#destroy'



  # Dodawanie użytkownika do grupy o danym ID
  post '/groupinfos/:id/users', to: 'groupinfos#add_user'

  # Usuwanie użytkownika o danym ID z grupy o danym ID
  delete '/groupinfos/:id/users', to: 'groupinfos#remove_user'


  # Tworzenie nowego zobowiązania dla grupy o danym ID i użytkowników o danych ID
  post '/groupinfos/:group_id/commitments', to: 'commitments#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
