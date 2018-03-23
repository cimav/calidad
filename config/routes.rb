Rails.application.routes.draw do

  root 'documents#index'
  resources :documents
  resources :users

  ########################################## sesiones
  get 'login' => 'login#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/logout' => 'sessions#destroy'

  ########################################## Documentos
  get '/:department_name/documentos' => 'documents#index_by_department'


end
