Rails.application.routes.draw do
  resources :condominium_fees
  resources :expenses
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

  post 'fees/generate', to: 'condominium_fees#generate_fees', as: 'generate_fees'

  root 'users/sessions#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
