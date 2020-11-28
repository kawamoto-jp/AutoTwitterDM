Rails.application.routes.draw do
  root to: "send_infos#new"

  resources :send_infos, only: [:index, :new, :create]
end
