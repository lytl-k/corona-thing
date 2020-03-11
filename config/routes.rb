Rails.application.routes.draw do
  root 'corona/home#index'

  namespace :corona do
    get '/cases', to: 'n_cov_16#cases'
    get '/recovered', to: 'n_cov_16#recovers'
    get '/deaths', to: 'n_cov_16#deaths'
  end
end
