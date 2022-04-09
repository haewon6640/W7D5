Rails.application.routes.draw do
  resources :posts, only: [:create, :edit, :update, :destroy, :show, :new]

  resources :subs, only: [:index, :show,:create, :new,:update, :destroy, :edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create, :index, :show]
  resource :session, only: [:new, :create, :destroy]

  root to: "subs#index"
end
