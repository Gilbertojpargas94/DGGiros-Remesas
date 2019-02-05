Rails.application.routes.draw do
  resources :quotations do
    member do
      get 'get_payment'
    end
  end
  get 'get_rates', to: 'quotations#get_rates'
  get 'get_banks', to: 'quotations#get_banks'
  resources :banks
  resources :rates
  resources :workers
  root 'home#index'
  # Go to registrations_controller for details
  devise_for :users, controllers: {sessions: "sessions",registrations: "registrations", passwords: "passwords"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
