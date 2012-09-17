BarcampGarden::Application.routes.draw do

  match '/events/featured_schedule' => 'events#show_featured_schedule', 
	  :via => [:get],
	  :as => :featured_schedule

  match '/events/:id/schedule' => 'events#show_schedule', 
	  :via => [:get],
	  :as => :event_schedule

  match '/events/featured_missing' => 'events#show_featured_missing', 
	  :via => [:get],
	  :as => :featured_missing

  match '/mediastream' => 'events#show_featured_remote_media',
	  :via => [:get],
	  :as => :featured_media

  match '/events/:event_id/remote_media_updates(.:format)' => 'remote_media#updates',
	  :via => [:get],
	  :as => :event_remote_media_updates

  match '/schedule' => 'events#show_featured_schedule'

  resources :events do
	  resources :rooms
	  resources :slots
	  resources :workshops
	  resources :remote_media
  end

  resources :users
  resources :authentications

  devise_for :users, :path => 'access'

  match '/auth/:provider/callback' => 'authentications#create'  

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

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
  #root :to => 'high_voltage/pages#show', :id => 'index'
  root :to => 'events#show_featured'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
