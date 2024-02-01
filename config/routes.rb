Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'welcome#index'
  get 'description', to: 'homes#description', as: 'description'
  resources :questions, only: [:index, :new, :create]
  post '/questions/get_next_question', to: 'questions#get_next_question'
  resources :documents, only: [:index, :create]
  get '/get_upcoming_events', to: 'events#get_upcoming_events'
  resources :events, only: [:index, :create]
  resources :grants
  resources :users do
    member do
      post 'reset_score'
    end
  end
  resources :past_exams, only: [:index, :show] do
    member do
      post 'answer'
      get 'explanation'
      get 'next_question' 
      get 'result'
      get 'retry_incorrect_answers'
      post 'retry_selected'
    end
  end
  get 'next_question', to: 'past_exams#next_question', as: 'next_question'
  get 'past_exams/:id/retry_selected', to: 'past_exams#retry_selected', as: :retry_selected_for_exam
  resources :vocabulary_notes do
    resources :vocabulary_entries, only: [:new, :create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
