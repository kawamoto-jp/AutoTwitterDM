Rails.application.routes.draw do
  root to: "send_infos#new"

  resources :send_infos, only: [:index, :new, :create] do
    collection do
      delete 'destroy_all'
    end
  end
  resources :dm, only: :new
end
