Talk::Application.routes.draw do
  root to: "dashboards#show"

  namespace :api, defaults: { format: :json } do
    resources :contacts, only: [:create, :index, :show]
    resources :conversations, only: [:create]
    resource :sessions, only: [:create]
  end

  resources :users, only: [] do
    resources :contacts, only: [:create]
  end

  resources :contacts, only: [] do
    resources :conversations, only: [:create]
  end
end
