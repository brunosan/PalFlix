class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

private
 
  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'pal' && password == 'pal'
    end
  end
  
end
