class MoviesController < ApplicationController
 
before_filter :authenticate
before_filter :admin_user,   :only => [:edit, :update, :destroy]

def new
    @title= "Add Movie"
    @movie=Movie.new
  end

  def show
    @movie=Movie.find(params[:id])
    @title= @movie.title
    @rating_best= @movie.ratings.find(:all, :order => "grade", :limit => 3)
    @ratings= @movie.ratings.paginate(:page => params[:page])
  end

  def create
    @movie= Movie.new(params[:movie])
    if @movie.save
      flash[:success] = "The Movie '#{@movie.title}' is now safe with us."
      redirect_to @movie
    else
      flash[:error] = "Something went wrong, sorry. Try it again."
      @title="New Movie"
      render 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
    @title = "Edit movie"
  end
 
  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(params[:movie])
      flash[:success] = "Movie info updated."
      redirect_to @movie
    else
      flash[:error] = "Something went wrong, sorry. Try it again."
      @title = "Edit movie"
      render 'edit'
    end
  end
  
  def index
    @title = "All Movies"
    @movies = Movie.paginate(:page => params[:page])
    @movies_total = Movie.count
  end

def destroy
    Movie.find(params[:id]).destroy
    flash[:success] = "Movie deleted."
    redirect_to movies_path
  end
  
 
private

def authenticate
      deny_access unless signed_in?
end

private

def admin_user
  unless current_user.admin?
      flash[:error] = "Sorry, only admins can do that."
      redirect_back_or(movies_path)
  end
end

end
