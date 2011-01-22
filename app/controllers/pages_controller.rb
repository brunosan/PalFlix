class PagesController < ApplicationController
  def home
    @title = "Home"
    @users_total = User.count
    @movies_total = Movie.count
    @user_last = User.last
    @movie_last = Movie.last
    @last_login=User.find(:first, :order => "updated_at ASC", :limit => 1).updated_at
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

end
