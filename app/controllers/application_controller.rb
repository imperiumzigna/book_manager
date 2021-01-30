class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  private
    def user_not_authorized
      redirect_to(request.referrer || root_path, notice: "You are not authorized to perform this action.")
    end

    def resource_not_found
      redirect_to root_path, notice: "Book not found"
    end
end
