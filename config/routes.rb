Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      resource :user_auth_token, only: [:create]
      resources :images, only: [:index, :create, :update]
    end
  end
end
