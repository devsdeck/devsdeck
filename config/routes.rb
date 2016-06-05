Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :cards do
    patch "like"
  end

  root "cards#index"

  require "sidekiq/web"
  require "sidekiq/cron/web"
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end
end
