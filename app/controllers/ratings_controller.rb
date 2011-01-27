class RatingsController < ApplicationController
 
before_filter :authenticate, :only => [:create, :destroy]

def index
    @title = "All ratings"
    @ratings = Rating.paginate(:page => params[:page])
    @ratings_total = Rating.count
end

def create
  @rating = current_user.ratings.build(params[:rating])
  if @rating.save
    flash[:success]= "Rating created, thanks!"
    redirect_to current_user
  else
    flash[:error]= rating.errors
    redirect_to current_user
  end

end

def destroy

end
 
private

def authenticate
      deny_access unless signed_in?
end


end
