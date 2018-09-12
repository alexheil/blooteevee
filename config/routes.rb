Rails.application.routes.draw do
  
  root 'static_pages#home'

  get 'become-member' => 'static_pages#home'

  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations", confirmations: "users/confirmations",  unlocks: "users/unlocks"}

  devise_scope :user do
    get 'sign_out', to: 'users/sessions#destroy', path: 'sign-out'
    get 'sign_in', to: 'users/sessions#new', path: 'sign-in'
    get 'register', to: 'users/registrations#new'
  end

  resources :users, controller: 'users/users', only: :show do
    resource :profile, controller: 'users/profiles', only: [:edit, :update]
    resource :merchant, controller: 'users/merchants', only: [:new, :create, :edit, :update]
    get 'edit_source', to: 'users#edit_source', path: 'users/:id/edit-source'
    patch 'update_source', to: 'users#update_source', path: 'users/:id/update-source'
    get 'edit_plan', to: 'users#edit_plan', path: 'users/:id/edit-plan'
    patch 'update_plan', to: 'users#update_plan', path: 'users/:id/update-plan'
  end



end
