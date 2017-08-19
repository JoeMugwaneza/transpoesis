Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'posts#index'

  resources :users
  resources :posts do 
    resources :comments
    end
  resources :sessions


  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # designs routes
  get "/home" => "designs#home"
  get "/poets" => "designs#poets"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
