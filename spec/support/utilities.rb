include ApplicationHelper

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def fill_in_signup_form(user)
  fill_in "Name",         with: user.name
  fill_in "Email",        with: user.email
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
