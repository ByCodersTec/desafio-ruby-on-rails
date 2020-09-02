Rails.application.routes.draw do
  resources :financial_transactions, only: [:new, :create]

  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1 do
      resources :financial_transactions, only: [:index]
    end
  end
end
