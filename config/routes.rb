Rails.application.routes.draw do

  devise_for :users
  resources :journals, except: [:index]
  resources :journal_feeds

  root 'journals#index'

end
