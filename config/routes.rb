Rails.application.routes.draw do
  root 'pages#index'
  get '/privacy-agreement', to: 'pages#privacy_agreement', as: 'privacy_agreement'
  get '/instalinks', to: 'instalinks#index', as: 'instalinks'

  devise_for(
    :users,
    path: '',
    path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: { sessions: 'sessions' }
  )
  # get 'sitemap.xml.gz', to: redirect("https://#{ENV['S3_BUCKET_NAME']}.s3.#{ENV['AWS_REGION']}.amazonaws.com/sitemap.xml.gz")
  get 'sitemap.xml.gz', to: redirect("https://console.cloud.google.com/storage/browser/#{ENV['GCS_BUCKET']}/sitemap.xml.gz")
  resources :calls, only: [:create]

  scope '/cart' do
    post '/', to: 'cart#show_cart', as: 'show_cart'
    post '/:id/add-product', to: 'cart#add_product', as: 'add_product'
    post '/:id/remove-products', to: 'cart#remove_products', as: 'remove_products'
    post '/:id/plus-product', to: 'cart#plus_product', as: 'plus_product'
    post '/:id/minus-product', to: 'cart#minus_product', as: 'minus_product'
  end

  # магазин
  namespace :shop do
    get '/products/:id/category', to: 'products#index', as: 'category_products'
    resources :products, only: [:show]
    resources :orders, only: [:new, :create]
    resources :order_calls, only: [:create]
    scope '/search-products' do
      post '/', to: 'search_products#search', as: 'search_products_client_search'
      post '/:request', to: 'search_products#detected', as: 'search_products_client_detected'
      get  '/:request', to: 'search_products#index', as: 'search_products_client_index'
    end
  end
  # админ панель
  namespace :admin do
    get '/', to: 'calls#index', as: 'calls'
    get '/category/:id/products', to: 'products#category_products', as: 'category_products'
    scope '/contacts' do
      get '/', to: 'contacts#index', as: 'contacts'
      post '/', to: 'contacts#update', as: 'contacts_update'
    end
    scope '/calls' do
      get '/arhive', to: 'calls#arhive', as: 'calls_arhive'
      patch '/:id/complete', to: 'calls#complete', as: 'call_complete'
      patch '/calls/:id/save', to: 'calls#save', as: 'call_save'
    end
    resources :calls, only: [:index, :edit, :update, :destroy]
    resources :order_calls, only: [:index, :edit, :update, :destroy]
    scope '/order-calls' do
      get '/arhive', to: 'order_calls#arhive', as: 'order_calls_arhive'
      patch '/:id/complete', to: 'order_calls#complete', as: 'order_call_complete'
      patch '/:id/save', to: 'order_calls#save', as: 'order_call_save'
      patch '/:id/toogle-available', to: 'order_calls#toogle_available', as: 'order_call_toogle_available'
    end

    resources :products, except: [:show, :destroy]
    delete '/products/:id/:from_place', to: 'products#destroy', as: 'product_destroy'
    resources :categories, except: [:show]
    resources :portfolios, except: [:show]
    resources :orders, except: [:new, :create, :show]

    scope '/orders' do
      get '/arhive', to: 'orders#arhive', as: 'orders_arhive'
      patch '/:id/complete', to: 'orders#complete', as: 'order_complete'
      patch '/:id/save', to: 'orders#save', as: 'order_save'
    end

    scope '/search-products' do
      get '/', to: 'search_products#index', as: 'search_products_index'
      post '/', to: 'search_products#search', as: 'search_products_search'
      post '/:request', to: 'search_products#detected', as: 'search_products_detected'
    end
    resources :instalinks, only: [:index, :edit, :update]
  end

  match '/403', to: 'errors#forbidden', via: :all
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unacceptable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
