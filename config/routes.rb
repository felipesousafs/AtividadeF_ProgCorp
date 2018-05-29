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

  get 'apartments/:id/fees', to: 'apartments#fees', as: 'apartment_fees'
  get 'condominium_fees/:id/payment', to: 'condominium_fees#payment_page', as: 'payment_page'
  patch 'condominium_fees/:id/pay', to: 'condominium_fees#pay', as: 'pay_fee'
  post 'fees/generate', to: 'condominium_fees#generate_fees', as: 'generate_fees'

  root 'users/sessions#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
