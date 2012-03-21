Promesometro::Application.routes.draw do
  mount RailsAdmin::Engine => '/siteadmin', :as => 'rails_admin'
  devise_for :admines
  
  devise_for :ciudadanos, :controllers => {
      :omniauth_callbacks => "ciudadanos/omniauth_callbacks"
  }

  devise_scope :ciudadano do
    match "ciudadanos/profile/", :to => "ciudadanos/profile#update", :as => "ciudadanos_update_profile"
  end

  root :to => "home#show", :as => :root

  resources :promesas, :only => [:index] do
    resource :comments, :only => :create
  end

  resources :acerca_de, :only => [:index]
  resources :temas, :only => [:index]

  resource :promise_filter, :controller => :promise_filter, :only => [:create], :via => :get
  #match '/promesas_buscar/*query', :to => 'promise_filter#create', :via => :get, :as => :promise_filter

  namespace :social do
    #resource :meta_data
    match "/metadata/declaration/:id", :to => "meta_data#declaration", :as => :declaration_metadata
  end


  match "/estados/:estado/provincias", :to => "provincias#index"

  match "/representantes/:lugar", :to => "representantes#show"

  match "/promesas/:search/:query", :to => "promesas#index", :as => "promesas_filters"

  match "promesas/hito/:milestone_id/comentario", :to => "comments#create", :as => "hito_comentario"
  match "promesas/:slug", :to => "promesas#show", :as => "promesa"

  match "directorio", :to => "regiones#index", :as => "directorio"
  match "contacto/new", :to => "contacto#new", :as => "new_contacto"
  match "contacto", :to => "contacto#create", :as => "contacto", :via => :post
  match "regiones/:region_name", :to => "regiones#show", :as => "region"

  match '/token' => 'home#token', :as => :token

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
