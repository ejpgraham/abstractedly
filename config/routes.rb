Rails.application.routes.draw do
  devise_for :users
  resources :abstracts, only: [:index]
  resources :journals
  resources :journal_feeds
  resources :keywords
  resources :subscriptions, except: [:index]
  resources :users, only: [:update] #this adds subscriptions to users
  resources :custom_keywords

  root 'subscriptions#index'

end
