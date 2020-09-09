Rails.application.routes.draw do
  devise_for :users

  root 'home#top'
  get 'home/about'
  get 'search' => 'search#search'

  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
  		get 'follows' => 'relationships#follower', as: 'follows'
      get 'followers' => 'relationships#followed', as: 'followers'
  end

   resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
   	resource :favorites, only: [:create, :destroy]
     resource :book_comments, only: [:create, :destroy]
   end

end