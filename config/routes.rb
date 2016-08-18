Rails.application.routes.draw do
  root 'dashboard#index'

  namespace :api do
    root 'v1/links#index'
    namespace :v1 do
      root 'links#index'
      resources :links, except: [:new, :edit]
      resources :votes, except: [:new, :edit]
      resources :comments, except: [:new, :edit]
    end
  end
end
