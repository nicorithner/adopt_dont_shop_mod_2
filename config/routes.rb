Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #welcome
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  #shelters, pets
  get '/pets', to: 'pets#index'
  get '/shelters/:shelter_id/pets', to: 'shelters#pets_index'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  #favorites
  resources :favorites do
    member do
      patch :add_favorite
      patch :remove_favorite
    end
  end

  get '/favorites', to: 'favorites#index'
  delete '/favorites', to: 'favorites#remove_all_favorites'

  #reviews
  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'reviews#create'
  get '/shelters/:shelter_id/reviews', to: 'reviews#show'
  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  #adopt
  get '/favorites/adopt', to: 'favorites#index'
  post '/favorites/adopt', to: 'app#create'

  #applications
  get '/applications', to: 'app#index'
  get '/applications/:id', to: 'app#show'
  get '/pets/:id/applications', to: 'app#show_apps'
  post '/pets/:id/applications/approve', to: 'app#toggle_status'
  get '/pets/:id/adopt', to: 'pets#adopt'


  resources :app do
    member do
      patch :toggle_status
    end
  end


end
