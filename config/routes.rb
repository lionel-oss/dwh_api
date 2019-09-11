Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks',
  }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :remote_query, only: [:show], param: :name, path: 'api', defaults: {format: :json}
end
