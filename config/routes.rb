Hsd::Application.routes.draw do
  root :to => "pages#home"

  resources :pages do
    resources :versions, :controller => "pages/versions"
    resources :attachments, :controller => "pages/attachments"
  end
  resources :tags
  resources :changes

  resources :files do
    get '*path', :action => 'show', :on => :collection
  end
  
  namespace :admin do
    resources :users do
      post :confirm, :on => :member
    end
  end

  get "/sign_in", to:"sessions#new", as:"sign_in"
  get "/sign_out", to:"sessions#destroy", as:"sign_out"
  post "/welcome", to:"sessions#unlock", as:"unlock"
  match '/auth/:provider/callback', to:'sessions#create'
  match '/auth/failure', to:'sessions#failure'

  match "/index.html" => redirect("/")
  get '/home' => redirect("/")
  
  get    ':id' => 'pages#show', :as => :page
  put    ':id' => 'pages#update'
  delete ':id' => 'pages#destroy'
end
