Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  post 'books' => 'books#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
