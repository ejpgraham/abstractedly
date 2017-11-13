Rails.application.routes.draw do

  devise_for :users
  resources :journals

  root 'welcome#index'

end
