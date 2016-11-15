Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users, except:[:show]
  get 'users/account', to: 'users#account', as: :account_user
  get 'users/account/edit', to: 'users#edit'


  root to: 'static_pages#home'
  get '/help', to: 'static_pages#help'

  devise_for :users, controllers: {
    registrations: "users/registrations",
    confirmations: "users/confirmations"
  }

  devise_scope :user do
    patch "users/confirmation", to: "users/confirmations#confirm"
  end

end
