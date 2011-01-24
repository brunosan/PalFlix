require 'spec_helper'

describe Movie do
  before(:each) do
    @attr={:title=> "awesome movie"}
  end

  it "should create a new movie given a title" do
    Movie.create!(@attr)
  end


  it "should require a title" do
    no_name_movie=Movie.new(@attr.merge(:title => ""))
    no_name_movie.should_not be_valid
  end

  it "should reject very long names" do
    long_name_movie=Movie.new(@attr.merge(:title => "a"*51))
    long_name_movie.should_not be_valid
  end


  it "should be a unique title" do
    # Put a movie with given title into the database.
    Movie.create!(@attr)
    movie_with_duplicate_title = Movie.new(@attr)
    movie_with_duplicate_title.should_not be_valid
  end

  it "should be a unique title, also up case" do
    # Put a movie with given title into the database.
    upcase_title=@attr[:title].upcase
    Movie.create!(@attr.merge(:title => upcase_title))
    movie_with_duplicate_title = Movie.new(@attr)
    movie_with_duplicate_title.should_not be_valid
  end

  describe "rating associations" do

    before(:each) do
      @user = Factory(:user)
      @movie = Factory(:movie)
      @r1 = Factory(:rating, :user => @user, :movie => @movie, :created_at => 1.day.ago)
      @r2 = Factory(:rating, :user => @user, :movie => @movie,  :created_at => 1.hour.ago)
    end

    it "should have a ratings attribute" do
      @movie.should respond_to(:ratings)
    end

    it "should have the right ratings in the right order" do
      @movie.ratings.should == [@r2, @r1]
    end

    it "should destroy associated ratings" do
      @user.destroy
      [@r1,@r2].each do |rating|
        Rating.find_by_id(rating.id).should be_nil
      end
    end
  end

  
end
