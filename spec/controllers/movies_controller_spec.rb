require 'spec_helper'

describe MoviesController do
  render_views

describe "GET 'index'" do

    describe "for non-signed-in movies" do
      it "should not be successful" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for signed-in users" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @movies= [Factory(:movie)]
        10.times do
          @movies << Factory(:movie, :title =>Factory.next(:title))
        end
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All Movies")
      end

      #it "should have an element for each movie" do
      #  get :index
      #  @movies.each do |movie|
      #    response.should have_selector("a", :content => movie.title)
      #  end
      #end

      it "should paginate movies" do
        get :index
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/movies?page=2",
                                           :content => "2")
        response.should have_selector("a", :href => "/movies?page=2",
                                           :content => "Next")
      end
    end
  end


  describe "GET 'new'" do

    before(:each) do
        @user = test_sign_in(Factory(:user))
    end

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Add Movie")
    end
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @attr={ :title => "" }
      end

      it "should not create an empty movie" do
        lambda do
          post :create, :movie => @attr
        end.should_not change(Movie,:count)
      end
      
      it "should have the right title" do
        post :create, :movie => @attr
        response.should have_selector("title", :content => "New Movie")
      end

      it "should render the 'new' page" do
        post :create, :movie => @attr
        response.should render_template('new')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :title => "New Movie" }
        @user = test_sign_in(Factory(:user))
      end

      it "should create a movie" do
        lambda do
          post :create, :movie => @attr
        end.should change(Movie, :count).by(1)
      end

      it "should redirect to the movie show page" do
        post :create, :movie => @attr
        response.should redirect_to(movie_path(assigns(:movie)))
      end
      
      it "should have a success message" do
        post :create, :movie => @attr
        flash[:success].should =~ /Safe with us/i
      end
      
    end
  end
  
  describe "GET 'show'" do

    before(:each) do
        @user = test_sign_in(Factory(:user))
        @movie = Factory(:movie)
    end

    it "should be successful" do
      get :show, :id => @movie
      response.should be_success
    end

    it "should find the right movie" do
      get :show, :id => @movie
      assigns(:movie).should == @movie
    end
    
    it "should have the right title" do
      get :show, :id => @movie
      response.should have_selector("title", :content => @movie.title)
    end

  end
  
  describe "GET 'edit'" do
   
    before(:each) do
        @user = test_sign_in(Factory(:user))
        @user.admin=true
        @movie = Factory(:movie)
    end

    it "should not be successful for non admin" do
      @user.admin=false
      test_sign_in(@user)
      get :edit, :id => @movie
      response.should_not be_success
    end

    it "should have the right title" do
      get :edit, :id => @movie
      response.should have_selector("title", :content => "Edit movie")
    end

  end
  describe "PUT 'update'" do

    before(:each) do
        @user = Factory(:user)
        @user.admin=true
        test_sign_in(@user)
        @movie = Factory(:movie)
    end

    describe "failure" do

      before(:each) do
        @attr = { :title => ""}
      end

      it "should render the 'edit' page" do
        put :update, :id => @movie, :movie => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @movie, :movie => @attr
        response.should have_selector("title", :content => "Edit movie")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :title => "New title"}
      end

      it "should change the movie's attributes" do
        put :update, :id => @movie, :movie => @attr
        @movie.reload
        @movie.title.should  == @attr[:title]
      end

      it "should redirect to the movie show page" do
        put :update, :id => @movie, :movie => @attr
        response.should redirect_to(movie_path(@movie))
      end

      it "should have a flash message" do
        put :update, :id => @movie, :movie => @attr
        flash[:success].should =~ /updated/
      end
    end
  end
  
  describe "authentication of edit/update pages" do

    before(:each) do
        @user = test_sign_in(Factory(:user))
        @movie = Factory(:movie)
    end
    
    describe "for non-admin users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @movie
        response.should redirect_to(movies_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @movie, :movie => {}
        response.should redirect_to(movies_path)
      end
    end
    
    describe "for admin" do

      before(:each) do
        @user.admin=true
        test_sign_in(@user)
      end
    end
    
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
      @movie = Factory(:movie)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @movie
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin movie" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @movie
        response.should redirect_to(movies_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admind@example.es", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the movie" do
        lambda do
          delete :destroy, :id => @movie
        end.should change(Movie, :count).by(-1)
      end

      it "should redirect to the movies page" do
        delete :destroy, :id => @movie
        response.should redirect_to(movies_path)
      end
    end
  end
  
  

end
