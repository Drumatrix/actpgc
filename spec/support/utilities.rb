include ApplicationHelper

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_in(user)
  visit signin_path
  valid_signin user
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def fill_in_signup_form(user, name = user.name, email = user.email)
  fill_in "Name",         with: name
  fill_in "Email",        with: email
  fill_in "Password",     with: user.password
  fill_in "Confirmation", with: user.password_confirmation
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_title do |title|
  match do |page|
    page.should have_selector('title', text: full_title(title))
  end
end

RSpec::Matchers.define :have_heading do |heading|
  match do |page|
    page.should have_selector('h1', text: heading)
  end
end

RSpec::Matchers.define :have_title_and_heading do |title, heading = title|
  match do |page|
    page.should have_title(title)
    page.should have_heading(heading)
  end
end

RSpec::Matchers.define :have_validation_error_messages do |message|
  match do |page|
    page.should have_selector 'div', text: message  
    page.should have_selector 'div#error_explanation li'        
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector 'div.alert.alert-success', text: message
  end
end 

RSpec::Matchers.define :have_profile_link do |user|
  match do |page|
    page.should have_link('Profile', href: user_path(user))
  end
end

RSpec::Matchers.define :have_settings_link do |user|
  match do |page|
    page.should have_link('Settings', href: edit_user_path(user))
  end
end

RSpec::Matchers.define :have_delete_link do |user = nil|
  match do |page|
    if user.nil?
      page.should have_link('Delete')
    else
      page.should have_link('Delete', href: user_path(user))
    end
  end
end

RSpec::Matchers.define :have_signin_link do
  match do |page|
    page.should have_link('Sign in', href: signin_path)
  end
end

RSpec::Matchers.define :have_signout_link do
  match do |page|
    page.should have_link('Sign out', href: signout_path)
  end
end

RSpec::Matchers.define :be_paginated do
  match do |page|
    page.should have_selector('div.pagination')
  end
end

RSpec::Matchers.define :have_change_profile_pic_link do
  match do |page|
    page.should have_link('change', href: 'http://gravatar.com/emails') }
  end
end

RSpec::Matchers.define :have_list_item do |item|
  match do |page|
    page.should have_selector('li', text: user.name)
  end
end

