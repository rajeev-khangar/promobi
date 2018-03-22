Rails.application.routes.draw do
  
  resources :projects do
    resources :tasks do 
      member do 
        post :change_status
      end
    end
  end

  devise_for :users
  root to: 'home#index'
end
