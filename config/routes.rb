Rails.application.routes.draw do
  root 'pokemons#index'
  resources :pokemons, only: [:index, :show, :create]
end
