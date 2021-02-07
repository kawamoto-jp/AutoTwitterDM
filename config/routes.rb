require 'sidekiq/web'
require 'sidekiq-scheduler/web'
  
Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"
  
  root to: "send_infos#new"

  resources :send_infos, only: [:index, :new, :create] do
    collection do
      delete 'destroy_all'
    end
  end
  resources :dm, only: :new
end
