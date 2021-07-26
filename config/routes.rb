Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :report do
        get '/all', to: 'reports#all', as: 'all'
        get '/min_max_average', to: 'reports#min_max_average', as: 'min_max_average'
        get '/summary', to: 'reports#summary', as: 'summary'
      end
      resources :users
      resources :invoices
      post '/deposit', to: 'operations#deposit', as: 'deposit'
      post '/transfer', to: 'operations#transfer', as: 'transfer'
    end
  end
end
