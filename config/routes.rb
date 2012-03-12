Hsd::Application.routes.draw do
  root :to => "wiki#home"

  resources :wiki, :controller => "wiki" do
    resources :versions, :controller => "wiki/versions"
  end
  resources :files do
    get '*path', :action => 'show', :on => :collection
  end
  
  #devise_for :users
  namespace :admin do
    resources :users do
      post :confirm, :on => :member
    end
  end


  match "/index.html" => redirect("/")
  get '/home' => redirect("/")
  
  #resources :dropbox, :controller => "dropsite/files" do
    #get '*path/edit', :action => 'edit', :on => :collection
    #get '*path', :action => 'show', :on => :collection
  #end

  # get 'application_form', :to => "static#application_form"  
  
  get    ':id' => 'wiki#show', :as => :page
  put    ':id' => 'wiki#update'
  delete ':id' => 'wiki#destroy'
end
