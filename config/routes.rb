Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
 resources :users
  post '/users/login', to: 'users#login'

  resources :urls, only: [:create, :show] do
     collection do
       post 'shorten_and_verify'
       post 'update_shorten'
     end
   end
end
