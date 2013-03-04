require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'ACTPGC'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => "ACTPGC")
    end
  
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "ACTPGC | Home")
    end
  end
  
  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => "Help")
    end
    
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "ACTPGC | Help")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => "About Us")
    end
    
    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "ACTPGC | About")
    end
  end
end 