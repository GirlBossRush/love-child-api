class ApplicationController < ActionController::Base

  skip_before_filter :verify_authenticity_token

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def health_check
    render json: { message: "healthy" }
  end

  # --- CORS ---
  def cors_set_access_control_headers
    headers.reverse_merge!(
      "Access-Control-Allow-Origin" => "*",
      "Access-Control-Allow-Methods" => "POST, GET, PUT, DELETE, OPTIONS",
      "Access-Control-Allow-Headers" => "Origin, Content-Type, Accept, Authorization, Token",
      "Access-Control-Max-Age" => "1728000"
    )
  end

  def cors_preflight_check
    if request.method == "OPTIONS"
      headers.reverse_merge!(
        "Access-Control-Allow-Origin" => "*",
        "Access-Control-Allow-Methods" => "POST, GET, PUT, DELETE, OPTIONS",
        "Access-Control-Allow-Headers" => "Content-Type, X-Requested-With, X-Prototype-Version, Token",
        "Access-Control-Max-Age" => "1728000"
      )

      render nothing: true, status: 200
    end
  end
  # ---

  # --- Error handling ---
  def throw_404
    # Unknown routes are directed here to be raised as exceptions.
    raise ActiveRecord::RecordNotFound, "Route '#{params[:path]}' not found"
  end

  rescue_from "ActiveRecord::RecordNotFound" do |e|
    render_status(404, e.message)
  end

  rescue_from "ActiveRecord::StatementInvalid" do |e|
    render_status(404, e.message)
  end

  # ---

  private
    def render_status(status, message = "")
      cors_set_access_control_headers

      render json: {
        message: message,
      },
      status: status
    end
  #end_private

end
