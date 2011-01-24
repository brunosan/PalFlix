class RatingsController < ApplicationController
 
before_filter :authenticate

def index
    @title = "All ratings"
    @ratings = Rating.paginate(:page => params[:page])
    @ratings_total = Rating.count
end

 
private

def authenticate
      deny_access unless signed_in?
end


end
