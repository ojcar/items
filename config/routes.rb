Items::Application.routes.draw do
  get "static/about"

  get "static/help"

  get "submitted_items/index"

  get "submitted_items/new"

  get "submitted_items/create"

  root :to => 'items#index'

  resources :items do
    get :autocomplete_author_name, :on => :collection
    get :autocomplete_category_name, :on => :collection
    get :autocomplete_source_name, :on => :collection
  end

  resources :sources do
    member do
      post 'subscribe'
    end
  end

  resources :categories
  
  resources :authors do
    member do
      post 'subscribe'
    end
  end
  

  get "author/index"

  get "author/show"

  get "author/edit"

  get "author/update"

  get "author/destroy"

  get "roles/index"

  get "roles/update"

  get "roles/destroy"

  resources :users, :user_sessions
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'

  resources :items

  match 'authors/:id/seguir' => 'authors#subscribe'
  match 'sources/:id/seguir' => 'sources#subscribe'
  
  resources :submitted_items
  match 'submit' => 'submitted_items#new', :as => :submititem
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
