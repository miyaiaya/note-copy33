Rails.application.routes.draw do
  devise_for :users
  root 'notes#index'
  resources :users, only: [:show, :edit, :update] do
   resources :magazines
  end
  resources :notes do
    resources :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
