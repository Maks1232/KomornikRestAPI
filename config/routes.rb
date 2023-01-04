Rails.application.routes.draw do
  resources :commitments
  resources :groupinfos do
    resources :commitments
  end
  resources :bills
  resources :users

  post "/login", to: "users#login"

  #-----------------------------------------------------------------------------------------------------------------------
  #-----------------------------------------------------------------------------------------------------------------------

  # Tworzenie nowej grupy
  post '/groupinfos', to: 'groupinfos#create'

  # Usuwanie grupy o danym ID
  delete '/groupinfos/:id', to: 'groupinfos#destroy'

  #-----------------------------------------------------------------------------------------------------------------------
  #-----------------------------------------------------------------------------------------------------------------------

  # Dodawanie użytkownika do grupy o danym ID
  post '/groupinfos/:id/users', to: 'groupinfos#add_user'

  # Usuwanie użytkownika o danym ID z grupy o danym ID
  delete '/groupinfos/:id/users', to: 'groupinfos#remove_user'

  #-----------------------------------------------------------------------------------------------------------------------
  #-----------------------------------------------------------------------------------------------------------------------

  # Tworzenie nowego zobowiązania dla grupy o danym ID i użytkowników o danych ID
  post '/groupinfos/:group_id/commitments', to: 'commitments#create'

  # Usuwanie zobowiązania dla grupy o danym ID
  delete '/groupinfos/:group_id/commitments/:id', to: 'commitments#destroy'

  # Aktualizacja istniejącego commitment dla grupy o danym ID
  patch '/groupinfos/:group_id/commitments/:id' , to: 'commitments#update'

  #-----------------------------------------------------------------------------------------------------------------------
  #-----------------------------------------------------------------------------------------------------------------------

  post '/commitments' , to: 'commitments#split'


end
