class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
	  # FIXME: test difference flash[:error] = exception.message
	  redirect_to root_path, :alert => exception.message
  end
end
