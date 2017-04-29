Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  get '/admin' => 'pages#truedashboard'



  get 'users/new'
  resource :users, :controllers => { :confirmations => "confirmations" }
  resources :pages


  get :send_reminder_mail, to: 'pages#send_reminder_mail', as: :send_reminder_mail
  get 'sessions/home' => 'sessions#home'
  get '/employees' => 'pages#employees'
  get '/timesheet' => 'pages#dashboard'
  get '/exports' => 'pages#exports'
  get '/approvals' => 'pages#approvals'
  get '/expenses' => 'pages#expenses'
  get '/expensesapprovals' => 'pages#expensesapprovals'
  post "/expenses" => "pages#create", :as => :create_page
  get '/exportsall' => 'pages#exportsall'
  get '/exportsDepart' => 'pages#exportsDepart'
  get '/exportsExpenses' => 'pages#exportsExpenses'
  get '/exportsBillable' => 'pages#exportsBillable'
  get '/exportsWeekExpenses' => 'pages#exportsWeekExpenses'
  get '/exportsWeekImages' => 'pages#exportsWeekImages'
  get '/dashboard' => 'pages#truedashboard'
  get '/edit_user' => 'users#edit_admin'
  #get '/settings' => 'devise/registrations#edit'
  root 'passthrough#index'

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
