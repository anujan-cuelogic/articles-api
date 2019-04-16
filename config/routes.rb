Rails.application.routes.draw do

  devise_for :authors
  resources :articles
  match '*any' => 'application#options', via: [:options]

  resources :quotes

  resources :users do
    member do
      put :update_profile
      put :profile_picture
    end
  end

  resource :authentication do
    post :login, on: :collection
  end

end
