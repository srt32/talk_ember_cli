Talk::Application.routes.draw do

  root to: "dashboards#show"

  resources :users, only: [] do
    resources :contacts, only: [:create]
  end

  resources :contacts, only: [] do
    resources :conversations, only: [:create]
  end

end
