Rails.application.routes.draw do

  scope "", defaults: { format: :json } do
    resources :stories

    # CORS preflight routes.
    match "/stories", controller: "stories", action: "create", via: [:post, :options]
    match "/stories/:id", controller: "stories", action: "update", via: [:post, :options]
  end

end
