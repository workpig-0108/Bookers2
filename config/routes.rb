Rails.application.routes.draw do
  get 'favorites/create'
  devise_for :users
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :books do
  	resources :post_comments,only: [:create, :destroy]
  end
  resource :favorites, only: [:create, :destroy]
  root 'homes#top'
  get 'home/about' => 'homes#about'
  post 'books' => 'books#create'
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'relationships/show/:id' => 'relationships#show'
end
