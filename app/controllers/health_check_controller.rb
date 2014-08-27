class HealthCheckController < ApplicationController
  def index
    render json: { message: "healthy" }
  end
end
