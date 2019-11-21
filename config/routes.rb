Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  root 'pages#index'

  get  'privacy-agreement', to: 'pages#privacy_agreement', as: 'privacy_agreement'
  resources :calls,        only: [:create]
  

  # магазин
  namespace :shop do
    get '/products_category/:id' => 'products#index', as: 'category_products'
    resources :products,    only: [:show]
    resources :orders,      only: [:new, :create]
    resources :order_calls, only: [:create]
  end

  # админ панель
  namespace :admin do
    get   '/',                      to: 'calls#index',                as: 'calls'
    
    get   '/contacts',              to: 'contacts#index',             as: 'contacts'
    get   '/category/:id/products', to: 'products#category_products', as: 'category_products'
    post  '/contacts',              to: 'contacts#update',            as: 'contacts_update'

    get   '/calls/arhive',          to: 'calls#arhive',               as: 'calls_arhive'
    patch '/calls/:id/complete',    to: 'calls#complete',             as: 'call_complete'
    patch '/calls/:id/save',        to: 'calls#save',                 as: 'call_save'

    resources :calls, only: [:index, :edit, :update, :destroy]

    get   '/order_calls/arhive',               to: 'order_calls#arhive',           as: 'order_calls_arhive'
    patch '/order_calls/:id/complete',         to: 'order_calls#complete',         as: 'order_call_complete'
    patch '/order_calls/:id/save',             to: 'order_calls#save',             as: 'order_call_save'
    patch '/order_calls/:id/toogle-available', to: 'order_calls#toogle_available', as: 'order_call_toogle_available'
    
    resources :order_calls, only: [:index, :edit, :update, :destroy]

    resources :products,     except: [:show]
    resources :categories,   except: [:show]
    resources :portfolios,   except: [:show]
    resources :orders,       except: [:new, :create]
  end

  post 'cart',                     to: 'cart#show_cart',       as: 'show_cart'
  post 'cart/:id/add-product',     to: 'cart#add_product',     as: 'add_product'
  post 'cart/:id/remove-products', to: 'cart#remove_products', as: 'remove_products'
  post 'cart/:id/plus-product',    to: 'cart#plus_product',    as: 'plus_product'
  post 'cart/:id/minus-product',   to: 'cart#minus_product',   as: 'minus_product'
end
