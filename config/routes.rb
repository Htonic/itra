Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  resources :comments
  devise_for :users, :controllers => 
   {omniauth_callbacks: 'omniauth_callbacks'  }
  resources :users do
    collection do
      delete 'destroy_multiple'
      get 'what_to_do'
    end
    resources :campaigns do
      resource :comments
    end
  end
  resources :users
  resources :campaigns do
    get 'donate'
    post 'donate'
    resources :news
    resources :rewards
  end
  resources :comments do
    resources :likes
  end
  get "search", to: "search#search"
  mount Markitup::Rails::Engine, at: "markitup", as: "markitup"
  get 'welcome/index'
  get 'rewards/donate'
  post 'rewards/donate'
  get 'welcome/about'
  get 'set_language/en'
  get 'set_language/ru'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  post 'user/campaign/new'
  post "markdown/preview"
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
