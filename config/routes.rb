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
  get '/documents/:id/new_reminder' => 'documents#new_reminder'
  post '/documents/:id/create_reminder' => 'documents#create_reminder'
  get '/master_list/:department_id' => 'documents#master_list'

  ########################################## Recordatorios
  get '/document_owners/:id/edit' => 'documents#edit_reminder'
  patch '/document_owners/:id/update' => 'documents#update_reminder'
  delete '/delete_reminder/:id' => 'documents#delete_reminder'

  ########################################## Departamentos
  patch '/update_department/:department_id' => 'documents#update_department'


  get '/get_personas' => 'documents#get_personas'
  get '/get_email' => 'documents#get_email'



end
