Conclave::Application.routes.draw do
  devise_for :users, controllers: {
    sessions:           "sessions",
    omniauth_callbacks: "omniauth_callbacks"
  }

  ActiveAdmin.routes(self)

  resources :users, :only => [:show, :index] do
    post :ban, on: :member
  end

  resources :forums, :only => [:show, :index] do
    resources :conversations, :only => [:new, :create, :index]
  end

  resources :conversations, :except => [:new, :create, :index] do
    resources :watches, :only => [:create] do
      delete :destroy, :on => :collection
    end
    resources :comments, :except => [:show]
  end

  root :to => "forums#index"
end
