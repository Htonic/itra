Rails.application.routes.draw do
  resources :comments
  devise_for :users, :controllers => 
   {omniauth_callbacks: 'omniauth_callbacks'  }
  resources :users do
    resources :campaigns do
      resource :comments
    end
  end
  resources :users
  resources :campaigns do
    resources :news
  end
  get "search", to: "search#search"
  get 'welcome/index'
  get 'welcome/about'
  get 'set_language/en'
  get 'set_language/ru'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  post 'user/campaign/new'
  post "markdown/preview"
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
