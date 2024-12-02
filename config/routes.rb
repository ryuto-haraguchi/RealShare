Rails.application.routes.draw do
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
      sessions: 'admin/sessions'
    }

  namespace :admin do

    root to: 'sessions#new'

    resources :users, only: [:index, :show, :update, :destroy]

    resources :posts, only: [:show, :destroy]

    resources :notices, only: [:index, :show, :update, :destroy]

    resources :reviews, only: [:show, :destroy]

  end

  devise_for :users, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  scope module: :public do

    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :users, only: [:index, :show, :update, :destroy] do
      get 'mypage' => 'users#mypage', on: :collection
      get 'edit_mypage' => 'users#edit', on: :collection
      resources :reviews, only: [:index]
      resources :bookmarks, only: [:index]
    end

    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :reviews, only: [:create, :destroy, :update]
      resources :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :groups, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      post 'join' => 'group_users#join'
      delete 'leave' => 'group_users#leave'
    end

    resources :notices, only: [:create, :new]

    resources :searches, only: [:index]

    resources :maps, only: [:index]

  end

end
