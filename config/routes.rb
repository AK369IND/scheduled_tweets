Rails.application.routes.draw do
  root to: 'main#index'

  get '/password/reset', to: 'password_resets#new'
  post '/password/reset', to: 'password_resets#create'
  get '/password/reset/edit', to: 'password_resets#edit'
  patch '/password/reset/edit', to: 'password_resets#update'

  get '/sign_up', to: 'registration#new'
  post '/sign_up', to: 'registration#create'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'

  # delete session[:user_id] i.e. nil
  delete '/logout', to: 'sessions#destroy'

  get '/password', to: 'passwords#edit', as: :edit_password
  patch '/password', to: 'passwords#update'

  get '/about', to: 'about#index' # , as: :<prefix name>

  get '/auth/twitter/callback', to: 'omniauth_callbacks#twitter'

  resources :twitter_accounts
  # this would create all crud operations as well as calling omniauth to delete a linked account
  # equivalent to or we can say it creates:
  #   get 'twitter_accounts/:id', to: 'twitter_accounts#index'
  #   delete 'twitter_accounts/:id'

  resources :tweets

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end