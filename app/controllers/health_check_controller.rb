class HealthCheckController < ApplicationController
  def index
    render json: { message: "healthy" }
  end

  protected
  def allow_http?
    true
  end
end
