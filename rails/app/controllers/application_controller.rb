class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def current_user
    # TODO: but I want to be a real boy!
    @current_user ||= User.first
  end
end
