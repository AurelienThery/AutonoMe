Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "activites", to: "activities#mes_activites"
  get "activities/:id", to: "activities#show", as: :activity
  # Defines the root path route ("/")
  # homepage correspondant au profil de l'utilisateur etant log-in
  get 'myprofil', to: 'users#show', as: "myprofil"
  get 'myprofil' => 'users#show', as: :myprofil_root # creates user_root_path after log in
  get 'help_needed', to: 'helpcalls#index'
  # route for stimulus controller (start/e)
  patch 'activites/:id/update_status', to: 'activites#start', as: 'update_activity_status'
end
