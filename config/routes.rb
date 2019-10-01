Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks',
  }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :remote_query, only: [:show], param: :name, path: 'api', defaults: {format: :json}

  root 'rails_admin/main#dashboard'
  get 'swagger_docs' => 'swagger#swagger_docs'
  get 'api_docs' => 'swagger#api_docs'
  get '/docs/:resource_name' => 'swagger#resource_docs'
end
