Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'static_pages#home'
  get '/help', to: 'static_pages#help'

  devise_for :users, controllers: {
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }
  get '/users/account', to: 'users#account'

  devise_scope :user do
    patch "users/confirmation", to: "users/confirmations#confirm"
  end

  resources :facilities,:except => [:update,:edit]
  resources :reservations,:only => [:destroy,:index]

end
