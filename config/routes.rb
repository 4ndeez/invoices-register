Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :invoices
      post '/deposit', to: 'operations#deposit', as: 'deposit'
      post '/transfer', to: 'operations#transfer', as: 'transfer'
    end
  end
end
