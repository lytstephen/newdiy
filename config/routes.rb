Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => :registrations }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :users do
    get :dashboard, on: :collection
  end

  get 'categories/index'

  resources :categories

  resources :orders

  post 'create_video_line_item' => 'orders#create_video_line_item'
  post 'create_materials_line_item' => 'orders#create_materials_line_item'
  resources :line_items, only: [:destroy]

  resources :courses do
    get :manage, on: :collection
    get :admin_manage, on: :collection
    get :admin_upload, on: :collection
  end

  root 'pages#index'

  get 'admin' => 'pages#admin'

  get 'cart' => 'pages#cart'
  get 'checkout' => 'pages#checkout'
  get 'payment' => 'pages#payment'

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
