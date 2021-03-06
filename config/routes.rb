Agiledme::Application.routes.draw do

  resources :epics do
    member do
      get :finish
    end
  end

  resources :labels

  resources :projects do
    member do
      get :join, :leave, :overview, :reports, :sprint, :import_pivotal_csv, :show_more_items
      post :upload_pivotal_csv, :search, :update_velocity_trend_report, :update_story_trend_report, :update_burndown_chart
    end
    resources :project_users
    resources :stories do
      member do
        get :start, :finish, :deliver, :accept, :reject, :restart, :estimate, :un_start, :un_finish, :un_deliver
        put :update_category_and_priority
      end
      resources :story_histories

    end
    resources :epics, :controller => :stories
    resources :features, :controller => :stories
    resources :bugs, :controller => :stories
    resources :chores, :controller => :stories
  end

  resources :story_attachments do
    member do
      get :download_attachment
    end
  end

  devise_for :users, :controllers => {:registrations => 'users/registrations'}


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
  root :to => "dashboard#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
