Rails.application.routes.draw do

  scope "", defaults: { format: :json } do
    resources :stories

    # CORS preflight routes.
    match "/stories", controller: "stories", action: "create", via: [:post, :options]
    match "/stories/:id", controller: "stories", action: "update", via: [:post, :options]

    get "/health-check", to: "application#health_check"
  end

  match "*path", to: "application#throw_404", via: :all
end
