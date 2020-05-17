Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  get 'sitemap.xml.gz', to: redirect("https://#{ENV['S3_BUCKET_NAME']}.s3.#{ENV['AWS_REGION']}.amazonaws.com/sitemap.xml.gz")
  root 'pages#index'
  get  'privacy-agreement', to: 'pages#privacy_agreement', as: 'privacy_agreement'
  resources :calls, only: [:create]
  post 'cart', to: 'cart#show_cart', as: 'show_cart'
  post 'cart/:id/add-product', to: 'cart#add_product', as: 'add_product'
  post 'cart/:id/remove-products', to: 'cart#remove_products', as: 'remove_products'
  post 'cart/:id/plus-product', to: 'cart#plus_product', as: 'plus_product'
  post 'cart/:id/minus-product', to: 'cart#minus_product', as: 'minus_product'
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  # магазин
  namespace :shop do
    get '/products/:id/category' => 'products#index', as: 'category_products'
    resources :products, only: [:show]
    resources :orders, only: [:new, :create]
    resources :order_calls, only: [:create]
    post '/search-products', to: 'search_products#search', as: 'search_products_client_search'
    post '/search-products/:request', to: 'search_products#detected', as: 'search_products_client_detected'
    get  '/search-products/:request', to: 'search_products#index', as: 'search_products_client_index'
  end
  # админ панель
  namespace :admin do
    get '/', to: 'calls#index', as: 'calls'
    get '/contacts', to: 'contacts#index', as: 'contacts'
    get '/category/:id/products', to: 'products#category_products', as: 'category_products'
    post '/contacts', to: 'contacts#update', as: 'contacts_update'
    get '/calls/arhive', to: 'calls#arhive', as: 'calls_arhive'
    patch '/calls/:id/complete', to: 'calls#complete', as: 'call_complete'
    patch '/calls/:id/save', to: 'calls#save', as: 'call_save'
    resources :calls, only: [:index, :edit, :update, :destroy]
    resources :order_calls, only: [:index, :edit, :update, :destroy]
    get '/order-calls/arhive', to: 'order_calls#arhive', as: 'order_calls_arhive'
    patch '/order-calls/:id/complete', to: 'order_calls#complete', as: 'order_call_complete'
    patch '/order-calls/:id/save', to: 'order_calls#save', as: 'order_call_save'
    patch '/order-calls/:id/toogle-available', to: 'order_calls#toogle_available', as: 'order_call_toogle_available'
    resources :products, except: [:show, :destroy]
    delete '/products/:id/:from_place', to: 'products#destroy', as: 'product_destroy'
    resources :categories, except: [:show]
    resources :portfolios, except: [:show]
    resources :orders, except: [:new, :create, :show]
    get '/orders/arhive', to: 'orders#arhive', as: 'orders_arhive'
    patch '/orders/:id/complete', to: 'orders#complete', as: 'order_complete'
    patch '/orders/:id/save', to: 'orders#save', as: 'order_save'
    get '/search-products', to: 'search_products#index', as: 'search_products_index'
    post '/search-products', to: 'search_products#search', as: 'search_products_search'
    post '/search-products/:request', to: 'search_products#detected', as: 'search_products_detected'
  end
end