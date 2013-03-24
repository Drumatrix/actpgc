require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    it { should have_title_and_heading('Sign up') }  
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_title_and_heading(user.name) }  
  end

  describe "signup" do
    
    before { visit signup_path }
    let (:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title ('Sign up') }
        it { should have_validation_error_messages('error') }
      end
      
    end

    describe "with valid information" do
      let (:user) { FactoryGirl.build(:user) }
      before { fill_in_signup_form (user) }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:saved_user) { User.find_by_email(user.email) }

        it { should have_title(saved_user.name) }
        it { should have_success_message('Welcome') }
        it { should have_link ('Sign out') }
      end      
    end
  end
end
