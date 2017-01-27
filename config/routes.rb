Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'invoices#index'
  resources :invoices, only: [:index, :create]
  resources :collections, only: [:index, :create]
end
