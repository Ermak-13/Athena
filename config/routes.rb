Athena::Application.routes.draw do
  root 'feeds#index'

  resources :feeds, only: [:index, :create]
end
