class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_authenticity_token

  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'http://love-child.com:3000'
    headers['Access-Control-Request-Method'] = '*'
  end

  private

  def invalid_authenticity_token
    render json: "Missing or invalid authenticity token", status: 422
  end
end
