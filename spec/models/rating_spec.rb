require 'spec_helper'

describe Rating do
  before(:each) do
    @user = Factory(:user)
    @movie = Factory(:movie)
    @attr= {:grade => 5, :movie_id => @movie.id}
  end

  it "should create a rating given a valid value" do
    @user.ratings.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @rating = @user.ratings.create(@attr)
    end

    it "should have a user attribute" do
      @rating.should respond_to(:user)
    end
      
    it "should have a movie attribute" do
      @rating.should respond_to(:movie)
    end


    it "should have the right associated user" do
      @rating.user_id.should == @user.id
      @rating.user.should == @user
    end
    
    it "should have the right associated movie" do
      @rating.movie_id.should == @movie.id
      @rating.movie.should == @movie
    end
  end

  describe "validations" do

    it "should require a user id" do
      Rating.new(:rating => 4, :movie_id => @movie.id).should_not be_valid
    end
    
    it "should require a movie id" do
      Rating.new(:rating => 4, :user_id => @user.id ).should_not be_valid
    end


    it "should require nonblank content" do
      @user.ratings.build(:movie_id => @movie.id ).should_not be_valid
    end

    it "should reject negative values" do
      @user.ratings.build(:rating => -4).should_not be_valid
    end

    it "should reject values above 10" do
      @user.ratings.build(:rating => 11).should_not be_valid
    end
  end
  

end
