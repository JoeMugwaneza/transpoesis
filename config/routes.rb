Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'posts#index'

  resources :users
  
  resources :posts do
    resources :favorites, only: [:create, :destroy]
    member do 
      get 'like', to: "posts#like"
      get 'unlike', to: "posts#unlike"
    end
    resources :comments
    end
    
  resources :sessions




  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # designs routes
  get "/home" => "designs#home"
  get "/poets2" => "users#poets2"
  get "/show" => "designs#show"
  get "/poet" =>  "designs#poet"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
