Rails.application.routes.draw do
  
  root 'static_pages#home'

  get 'privacy' => 'static_pages#privacy'
  get 'terms' => 'static_pages#terms'
  get 'become-member' => 'static_pages#become_member'

  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations", confirmations: "users/confirmations",  unlocks: "users/unlocks"}

  devise_scope :user do
    get 'sign_out', to: 'users/sessions#destroy', path: 'sign-out'
    get 'sign_in', to: 'users/sessions#new', path: 'sign-in'
    get 'register', to: 'users/registrations#new'
  end

  resources :users, controller: 'users/users', only: :show do
    resource :profile, controller: 'users/profiles', only: [:edit, :update]
    resource :membership, controller: 'users/memberships', only: [:new, :create, :edit, :update]
    resource :merchant, controller: 'users/merchants', only: [:new, :create, :edit, :update]
    get 'edit_source', to: 'users/users#edit_source', path: 'edit-source'
    patch 'update_source', to: 'users/users#update_source', path: 'update-source'
    resources :plans, controller: 'users/plans', only: [:new, :create, :edit, :update]
    # resources :videos, controller: 'instructors/videos', except: :index do
    #   resources :comments, controller: 'instructors/comments', only: [:create, :update, :destroy]
    # end
  end

end
