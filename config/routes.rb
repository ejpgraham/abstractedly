Rails.application.routes.draw do

  devise_for :users
  resources :journals, except: [:index]
  resources :journal_feeds, except: [:index]
  resources :keywords
  resources :subscriptions
  resources :users, only: [:update]

  root 'journal_feeds#index'

end
