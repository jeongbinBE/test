MenuMap::Application.routes.draw do

	# Root page is index and it's also brandpage.
	root 'home#index'

	# Static pages.
  get "manual", 	to:		 "home#manual"
  get "help", 		to: 	 "home#help"

	get "test",     to:		 "home#test"

	# update sub_categories on select box.
  get "search", 	to:		 "home#search"
	get "home/update_sub_categories", as: "update_sub_categories"

	# User pages
	get  'signup',			to:  'users#signup'
	post 'signup',      to:  'users#create'
	resources :users, param: :username, except: [:new, :create]

	# Log in/out.
	get    'login',    to:	 'sessions#new'
	post   'login', 	 to:	 'sessions#create'
	delete 'logout',   to:   'sessions#destroy' 

  # User account activation
	resources :account_activations, only: [:edit]

	# User's password resets.
	resources :password_resets, only: [:new, :create, :edit, :update]

	# Restaurants' index and page
	resources :restaurants, only: [:index, :show]

	#	resources :users, except: [:show, :new]
	# resoucees should be at the bottom because of the priority issue.

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
