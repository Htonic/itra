Rails.application.routes.draw do
  devise_for :users, :controllers => 
   {omniauth_callbacks: 'omniauth_callbacks'  }
  resources :users do
    resources :campaigns
  end
  resources :users
  resources :campaigns
  get 'welcome/index'
  get 'set_language/en'
  get 'set_language/ru'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  post 'user/campaign/new'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
