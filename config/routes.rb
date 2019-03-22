Rails.application.routes.draw do

  resources :articles
  match '*any' => 'application#options', :via => [:options]

  resources :quotes
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
