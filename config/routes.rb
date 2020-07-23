Rails.application.routes.draw do
  get 'favorites/create'
  devise_for :users
  resources :users
  resources :books do
  	resources :post_comments,only: [:create, :destroy]
  end
  resource :favorites, only: [:create, :destroy]
  root 'homes#top'
  get 'home/about' => 'homes#about'
  post 'books' => 'books#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
