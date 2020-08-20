Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :credentials
      resources :events, only: [:index]
      resources :users do
        resources :credentials
      end
    end
  end
end

  # resources :users do
  #   resources :credentials
  # end

  # resources :users
  # resources :credentials

#   resources :events, only: [:index]
# end
