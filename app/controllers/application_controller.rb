class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from StandardError do |exception|
    if Rails.env == "development"
      binding.pry
    else
      return render_server_error("Internal server error")
    end
  end

  def authenticate
    unless http_authorization_header = request.env["HTTP_AUTHORIZATION"]
      return render_unauthorized("No HTTP_AUTHORIZATION header found.")
    end

    http_authorization_header_parts = http_authorization_header.split("\"")

    unless http_authorization_header_parts.length == 2
      return render_unauthorized("Incompatible HTTP_AUTHORIZATION header found.")
    end

    token_string = http_authorization_header_parts.last

    unless @current_person = Person.find_by(token: token_string)
      return render_unauthorized("No user with matching token was found.")
    end

    @current_person
  end

  def render_server_error(message)
    render json: { message: message }, status: 500
  end

  def render_unauthorized(message)
    render json: { message: message }, status: 403
  end
end
