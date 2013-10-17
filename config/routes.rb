Cufflink::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  get 'settings' => 'users#settings'

  get "friendships/approve" => "friendships#approve"
  get "friendships/deny" => "friendships#deny"

  get "users/feed" => "users#feed"

  resources :notifications, only: [:destroy]

  resources :users do
    resources :contacts, only: [:create, :new]
    resources :statuses, only: [:create]
    resources :friendships, only: [:new, :create, :destroy]
    resources :messages, only: [:index]
  end

  resources :contacts, only: [:destroy]
  get 'messages/autocomplete' => 'messages#autocomplete'
  resources :messages, only: [:new, :create, :show]

  resources :experiences, only: [:update, :destroy, :create, :index, :new]

  resources :companies do
    resources :contacts, only: [:create, :new]
    resources :memberships, only: [:create, :destroy]
    resources :statuses, only: [:create]
  end

  resources :statuses, only: [:new, :create] do
    resources :responses, only: [:create]
  end

  resource :session, only: [:new, :create, :destroy]

  root to: 'users#feed'


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
