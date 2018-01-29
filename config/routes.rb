Rails.application.routes.draw do
  devise_for :users
  resources :journals
  resources :journal_feeds
  resources :keywords
  resources :subscriptions, except: [:index]
  resources :users, only: [:update]

  root 'subscriptions#index'

end
