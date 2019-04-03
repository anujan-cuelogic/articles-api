Rails.application.routes.draw do

  devise_for :authors
  resources :articles
  match '*any' => 'application#options', :via => [:options]

  resources :quotes
  resources :users
  post 'update_user', to: 'users#update_current_user'

  resource :authentication do
    post :login, on: :collection
  end

end
