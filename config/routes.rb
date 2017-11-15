Rails.application.routes.draw do

  devise_for :users
  resources :journals, except: [:index]

  root 'journals#index'

end
