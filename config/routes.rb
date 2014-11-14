Tour::Application.routes.draw do
  root :to => "admin/dashboard#index"

  devise_for :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :place
  resources :category
  resources :event
  resources :dbinfo
  
  namespace :api do
    namespace :v1 do
      resources :tokens, :only => [:create, :destroy]
    end
  end

  match 'places/find' => 'place#find'
  match 'places/my_places' => 'place#my_places'
  match 'places/near_me' => 'place#near_me'
  match 'dbinfos/get_doe' => 'dbinfo#get_doe'
  match 'places/places_of_interest' => 'place#places_of_interest'
  match 'places/near_me_sort' => 'place#near_me_sort'
  match 'places/top_rated_sort' => 'place#top_rated_sort'
  match 'reviews' => 'place#reviews'
  match 'place_of_interest' => 'place#place_of_interest', :via=> :post
  match 'place_of_interest_remove' => 'place#place_of_interest_remove', :via=> :post
  match 'get_alerts' => 'alert#get_alerts', :via=> :post
  match 'rating/update' => 'rating#update', :via=> :post
  match 'review/create' => 'review#create', :via=> :post
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
