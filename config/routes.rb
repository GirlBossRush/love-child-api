Rails.application.routes.draw do

  scope :api, defaults: { format: :json } do
    resources :stories
  end

  root to: 'application#foundation'
  get '*path', to: 'application#foundation'
end
