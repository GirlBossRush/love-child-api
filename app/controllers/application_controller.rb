class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_authenticity_token

  def foundation
    render "foundation"
  end

  private

  def invalid_authenticity_token
    render json: "Missing or invalid authenticity token", status: 422
  end
end
