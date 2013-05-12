require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('All users') }

    describe "pagination" do
      
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should be_paginated }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_list_item(user.name)
        end
      end

    end

    describe "delete links" do

      it { should_not have_delete_link }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_delete_link(user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_delete_link(user_path(admin)) }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_title_and_heading(user.name) }  
  end

  describe "signup page" do
    before { visit signup_path }
    it { should have_title_and_heading('Sign up') }  
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

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
        it { should have_signout_link('Sign out') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_heading("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_change_profile_pic_link }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_validation_error_message('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before { fill_in_signup_form (user, new_name, new_email) }

      it { should have_title(new_name) }
      it { should have_success_message }
      it { should have_signout_link }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end
