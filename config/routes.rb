Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations'}
  devise_scope :user do
    namespace :users do
      post "/registrations/search", to: 'registrations#search'
      get "/registrations/new_admin", to: 'registrations#new_admin'
      post "/registrations/create_admin", to: 'registrations#create_admin'
      get "/registrations/new_batch", to: 'registrations#new_batch'
      post "/registrations/create_batch", to: 'registrations#create_batch'
      get "/registrations/:id/edit_user", to: 'registrations#edit_user'
      patch "/registrations/:id/update_user", to: 'registrations#update_user'
      resources :registrations
    end
  end

  root 'pages#index'
  get '/curriculum' => 'curriculum#index'
  get '/curriculum/select_cohort' => 'curriculum#select_cohort'
  get '/grades' => 'cohorts#grades'
  get '/next_assignment' => 'assignments#next_to_grade'
  resources :cohorts
  resources :assignments
  get '/assignments/:id/show_demo', to: 'assignments#show_demo', as: 'assignment_show_demo'
  resources :assignment_versions
  get '/assignment_versions/:id/show_detailed' => 'assignment_versions#show_detailed'
  namespace :api do
    namespace :v1 do
      get 'submissions/download_file' => 'submissions#download_file'
      resources :submissions, format: "json"
      resources :comments, format: "json"
      post '/grades', to: 'grades#create'
      post '/grades/check_current', to: 'grades#check_current'
    end
  end
  
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
