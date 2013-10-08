require 'spec_helper'

describe "User pages" do  
  subject{ page }
  
  describe "profile page" do
    let( :user ){ FactoryGirl.create( :user ) }
    before{ visit user_path(user) }

    it{ should have_content user.name }
    it{ should have_title user.name }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content( 'SignUp' ) }
    it { should have_title( full_title( 'SignUp' ) ) }
  end

  describe "signup" do
    before { visit signup_path }
    let( :submit ) { "Create my account" }

    describe "with invalid information" do
      it "should not create user" do
        expect { click_button submit }.not_to change( User, :count )
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_title ( full_title 'SignUp' ) }
        it { should have_content ( 'error' ) }
      end

      describe 'in user data' do
        before do
          fill_in "Name", with: 'Example User'
          click_button submit
        end

        it "should have error lines" do          
          expect( page ).to have_content "The form contains 4 errors"
          expect( page ).to have_content "* Email can't be blank"
          expect( page ).to have_content "* Email is invalid"
          expect( page ).to have_content "* Password is too short (minimum is 6 characters)"
          expect( page ).to have_content "* Password can't be blank"
        end
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: 'Example User'
        fill_in "Email", with: 'user@example.com'
        fill_in "Password", with: 'foobar'
        fill_in "Confirmation", with: 'foobar'
      end
      it "should create user" do
        expect { click_button submit }.to change( User, :count ).by( 1 )
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by email: 'user@example.com' }

        it { should have_title user.name }
        it { should have_selector "div.alert.alert-success" }
      end
    end
  end
end
