Rails.application.routes.draw do
  # Rotas para as listas de tarefas
  resources :todo_lists do
    # Rotas aninhadas para os itens de cada lista
    resources :items, only: [:create, :destroy, :update] do
      member do
        patch :toggle_complete
      end
    end
  end

  # Define a página inicial como a lista de todas as listas de tarefas
  root "todo_lists#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
