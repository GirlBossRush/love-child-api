Rails.application.routes.draw do

  scope "", defaults: { format: :json } do
    resources :stories
  end
end
