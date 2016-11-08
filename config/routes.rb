Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, except:[:show]
  get 'signup', to: 'users#new'
  get 'users/account', to: 'users#account', as: :account_user
  get 'users/:accesstoken', to: 'users#show', as: :show_user

  get 'sessions/new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'static_pages#home'
  get '/help', to: 'static_pages#help'

end
