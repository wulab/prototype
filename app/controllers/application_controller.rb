class ApplicationController < ActionController::Base
  protect_from_forgery
  # Included module contents will be available to all controllers and views.
  include SessionsHelper
end
