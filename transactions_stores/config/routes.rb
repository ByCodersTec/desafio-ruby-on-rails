Rails.application.routes.draw do
  resources :financial_transactions, only: [:new, :create]
end
