Pfm::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users do
    get "/" => "devise/registrations#new", :as => :new_user_registration
  end

  resources :users, :only => [:show, :edit, :update]
  resources :acumen_tests

  resources :accounts do
    collection do
      get :list
    end
  end

  resources :budgets

  resources :goals do
    collection do
      get :select
    end
  end

  resources :transactions
  resources :trends, :only => :index

  match '/home' => 'static#home'
  match '/about' => 'static#about'
  match '/how_it_works' => 'static#how_it_works'
  match '/faq' => 'static#faq'
  match '/terms_of_use' => 'static#terms_of_use'
  match '/help_create_account' => 'static#help_create_account'
  match '/dashboard' => 'dashboard#show'

  resource :contact_us, :only => [:create]
  match '/contact_us' => 'contact_us#new'

  # TODO: set special root for registered user

  # root :to => "dashboard#show"
  root to: 'static#home'

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
  # root :to => 'static#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
