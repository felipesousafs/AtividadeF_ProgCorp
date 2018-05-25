Rails.application.routes.draw do
  resources :apartments
  devise_for :users, path: "u", :controllers => {
      sessions: 'users/sessions'
  }
  devise_scope :user do
    authenticated :user do
      root 'apartments#index', as: :authenticated_root
    end

    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root
    end
  end

  root 'users/sessions#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
