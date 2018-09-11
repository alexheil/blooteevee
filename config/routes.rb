Rails.application.routes.draw do
  
  root 'static_pages#home'

  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords", registrations: "users/registrations", confirmations: "users/confirmations",  unlocks: "users/unlocks"}

  devise_scope :user do
    get 'sign_out', to: 'users/sessions#destroy', path: 'sign-out'
    get 'sign_in', to: 'users/sessions#new'
    get 'register', to: 'users/registrations#new'
    # get 'user_edit_plan', to: 'users/registrations#edit_plan', path: 'users/:id/edit-plan'
    # patch 'user_update_plan', to: 'users/registrations#update_plan', path: 'users/:id/update-plan'
  end


end
