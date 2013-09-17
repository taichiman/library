require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Library'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      expect( page ).to have_content( 'Sample App' )
    end
    it "should have title 'RoR|Home' "do
      visit '/static_pages/home'
      expect( page ).to have_title 'Library | Home'
    end
  end
  describe "Help page" do
    it "should have the content 'Help'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/help'
      expect( page ).to have_content( 'Help' )
    end
    it "should have title 'RoR|Help' "do
      visit '/static_pages/help'
      expect( page ).to have_title 'Library | Help'
    end
  end
  describe "About Us" do
    it "should have the content 'About Us'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/about'
      expect( page ).to have_content( 'About Us' )
    end
    it "should have title 'RoR|About Us' "do
      visit '/static_pages/about'
      expect( page ).to have_title 'Library | About'
    end
  end

end
