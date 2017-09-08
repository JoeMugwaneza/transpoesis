Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  root 'posts#index'

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'sessions'}


  devise_scope :user do
    get 'signout', to: 'devise/sessions#destroy', as: :signout
  end

  # as :user do
  #   get 'signin', to: 'devise/sessions#new', as: :new_user_session
  #   post 'signin', to: 'devise/sessions#create', as: :user_session
  #   get 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  #   end

  resources :users
  resources :posts do
    resources :favorites, only: [:create, :destroy]
    member do 
      get 'like', to: "posts#like"
      get 'unlike', to: "posts#unlike"
    end
    resources :comments, :feedbacks
    end
    
#customized routes 


  # designs routes
  get "/home" => "designs#home"
  get "/poets2" => "users#poets2"
  get "/show" => "designs#show"
  get "/poet" =>  "designs#poet"
  get "/authorized_personel" => "admin_dashboards#admin", as: 'authorize_personel'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
