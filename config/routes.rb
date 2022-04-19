Rails.application.routes.draw do
  root 'posts#index'
  resources :posts do
    resources :comments, only: %i[create]
  end

  get 'register', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :users, only: [:create]
  resource :session, only: %i[new create destroy]
end
