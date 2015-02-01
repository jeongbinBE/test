MenuMap::Application.routes.draw do

	# Root page is index and it's also brandpage.
	root 'home#index'

	# Static pages =============================
  get "manual", 	to:		 "home#manual"
  get "help", 		to: 	 "home#help"
  get "search", 	to:		 "home#search"
	
	# update sub_categories on select box.
	get "home/update_sub_categories", as: "update_sub_categories"

	# help pages
	get 	 'help/test', to: 'help_qnas#index'
	resources :help_qnas, except: [:show, :index]

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
	resources :restaurants, only: [:index, :show, :update]

	#	resources :users, except: [:show, :new]
	# resoucees should be at the bottom because of the priority issue.

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
