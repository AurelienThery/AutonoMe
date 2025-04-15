Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: "pages#home"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
  get "activites", to: "activities#mes_activites"
  get "activities/:id", to: "activities#show", as: :activity
  get "relative_dashboard", to: "users#relative_dashboard", as: :relative_dashboard
  get 'myprofil', to: 'users#show', as: "myprofil"
  get 'myprofil' => 'users#show', as: :myprofil_root
  get 'help_needed', to: 'helpcalls#index'
  patch 'activities/:activity_id/start', to: 'activities#start'
  patch 'activities/:activity_id/finish', to: 'activities#finish'
  get 'home', to: 'users#index', as: 'home'

  # Route pour créer un emploi du temps
  post 'schedules', to: 'schedules#create', as: 'schedules'

  # Route pour les activités
  resources :activities, only: [:create, :index]
end
