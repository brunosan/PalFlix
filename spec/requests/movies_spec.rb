require 'spec_helper'

describe "Movies" do

  describe "New Movie" do

    describe "failure" do

      it "should not make a new empty Movie" do
        lambda do
        visit new_movie_path
        fill_in "Title",         :with => ""
        click_button "Add movie"
        response.should render_template('movies/new')
        response.should have_selector("div#error_explanation")
        end.should_not change(Movie, :count)
      end
    end
    
    describe "success" do

      it "should make a new Movie" do
        lambda do
          visit new_movie_path
          fill_in "Title",      :with => "Awesome movie 2"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "safe")
          response.should render_template('movies/show')
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end

end

