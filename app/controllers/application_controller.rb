class ApplicationController < ActionController::Base
  include Pundit
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    # You can log the error or use exception.policy, exception.query if needed

    respond_to do |format|
      format.html { render 'errors/unauthorized', status: :forbidden }
      format.json { render json: { error: "You are not authorized to perform this action." }, status: :forbidden }
      format.turbo_stream { render 'errors/unauthorized', status: :forbidden }
    end
  end

end
