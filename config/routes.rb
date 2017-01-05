Rails.application.routes.draw do
  devise_for :users
  #get 'sessions/login,'

  #get 'sessions/home,'

 # get 'sessions/profile,'

 # get 'sessions/setting'
  #devise_for :user
  root 'pages#dashboard'
  get 'users/new'
  resource :users, :controllers => { :confirmations => "confirmations" }
  resources :pages


  get 'sessions/home' => 'sessions#home'
  get '/exports' => 'pages#exports'
  get '/approvals' => 'pages#approvals'
  get '/expenses' => 'pages#expenses'
  get '/expensesapprovals' => 'pages#expensesapprovals'
  post "/expenses" => "pages#create", :as => :create_page
  get '/exportsall' => 'pages#exportsall'
  get '/exportsDepart' => 'pages#exportsDepart'
  #get '/settings' => 'devise/registrations#edit'


  #match ':controller(/:action(/:id))(.:format)'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
