Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: "find#show"
        get '/find_all', to: "find#index"
        get '/random', to: "random#show"
        get '/:id/invoices', to: "invoices#index"
        get '/:id/transactions', to: "transactions#index"
      end
      resources :customers, only: [:index, :show]

      namespace :merchants do
        get '/find', to: "find#show"
        get '/find_all', to: "find#index"
        get '/random', to: "random#show"
        get '/:id/invoices', to: "invoices#index"
        get '/:id/items', to: "items#index"
        get '/:id/favorite_customer', to: "favorite_customer#show"
      end
      resources :merchants, only: [:index, :show]

      resources :items, only: [:index, :show]

      resources :invoices, only: [:index, :show]

      namespace :transactions do
        get '/random', to: "random#show"
        get '/find', to: "find#show"
        get '/find_all', to: "find#index"
        get '/:id/invoice', to: "invoices#show"
      end
      resources :transactions, only: [:index, :show]

      resources :invoice_items, only: [:index, :show]
    end
  end
end
