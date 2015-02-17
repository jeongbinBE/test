MenuMap::Application.routes.draw do

  get "add_rest_requests/new"
	# Root page is index and it's also brandpage.
	root 'home#index'

	# Static pages =============================
  get "manual", 	to:		 "home#manual"
  get "search", 	to:		 "home#search"
	
	# update sub_categories on select box.
	get "home/update_sub_categories", as: "update_sub_categories"

	# help pages
	get 	 'help', 	to: 'help_qnas#index' 
	resources :help_qnas, except: [:show, :index]
	resources :ask_qnas,  only:		[:create, :destroy]

	# add restaurant request
	resources :add_rest_requests, except: [:index, :edit, :update]

	get "test",     to:		 "home#test"

	# User pages ===============================
	get		 'signup',	 to:  'users#signup'
	post	 'signup',   to:  'users#create'
	resources :users, param: :username, except: [:new, :create]

	# Log in/out.
	get    'login',    to:	 'sessions#new'
	post   'login', 	 to:	 'sessions#create'
	delete 'logout',   to:   'sessions#destroy' 

  # User account activation
	resources :account_activations, only: [:edit]

	# User's password resets.
	resources :password_resets, only: [:new, :create, :edit, :update]


	# Restaurant pages =========================
	resources :restaurants, 				only: [:index, :show, :update]
	resources :mymap_relationships, only: [:create, :destroy]
	resources :rest_imgs, 					only: [:create, :destroy]
	resources :menus, 							only: [:create, :update, :destroy]
	resources :comments, 						only: [:create, :update, :destroy]
	resources :report_rest_errs, 		only: [:create, :destroy, :show]

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
