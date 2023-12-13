Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  authenticated :user do
    root 'homes#top', as: :authenticated_root
  end
  root 'welcome#index'
  get 'description', to: 'homes#description', as: 'description'
  resources :questions, only: [:index, :new, :create]
  post '/questions/get_next_question', to: 'questions#get_next_question'
  resources :documents, only: [:index, :create]
  resources :learning_roadmaps
  resources :grants
  resources :users do
    member do
      post 'reset_score'
    end
  end
  resources :past_exams, only: [:index, :show] do
    member do
      post 'answer'
      get 'result'
    end
  end
  resources :vocabulary_notes do
    resources :vocabulary_entries, only: [:new, :create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
