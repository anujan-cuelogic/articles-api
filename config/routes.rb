Rails.application.routes.draw do

  devise_for :authors
  resources :articles
  match '*any' => 'application#options', :via => [:options]

  resources :quotes

  resources :users do
    put :update_profile, on: :member
  end

  resource :authentication do
    post :login, on: :collection
  end

end
