Rails.application.routes.draw do

  scope :api, defaults: { format: :json } do
    resources :stories
  end

  root to: 'application#foundation'
  constraints subdomain: '' do
    get '*path', to: 'application#foundation'
  end
end
