Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  authenticated :user do
    root 'homes#top', as: :authenticated_root
  end
  resources :learning_roadmaps
  resources :grants
  resources :past_exams, only: [:index, :show] do
    member do
      get 'start'
      post 'answer'
    end
  end
  resources :vocabulary_notes do
    resources :vocabulary_entries, only: [:new, :create]
  end
  root 'welcome#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
