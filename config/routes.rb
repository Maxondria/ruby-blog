Rails.application.routes.draw do
  get 'sessions/new'
  root 'posts#index'
  resources :posts

  get 'register', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :users, only: [:create]
  resource :session, only: %i[new create destroy]
end
