Rails.application.routes.draw do
  uuid = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i

  scope "", defaults: { format: :json, constraints: {id: uuid} } do
    constraints id: uuid do
      resources :stories
      resources :users

      # CORS preflight routes.
      match "/stories", controller: "stories", action: "create", via: [:post, :options]
      match "/stories/:id", controller: "stories", action: "update", via: [:post, :options]

      get "/health-check", to: "application#health_check"
    end
  end

  match "*path", to: "application#throw_404", via: :all
end
