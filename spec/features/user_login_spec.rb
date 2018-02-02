require "rails_helper"

RSpec.feature "User Login", :type => :feature do

  feature "Login Actions for User" do
    scenario "Sing Up new user" , :js => true do
      visit 'localhost:3000'
      click_on 'Sign up'
      fill_in 'user[email]',with: Faker::Internet.email
      fill_in 'user[password]',with: '123456'
      fill_in 'user[password_confirmation]',with: '123456'
      click_on 'Sign up'
      sleep 2
      page.should have_content("No Tasks Yet")
      page.find('#logout',visible: false).click()
    end

    scenario "Login User", :js => true do
      @user = User.create(email: Faker::Internet.email,password: '123456')
      visit 'localhost:3000'
      fill_in 'user[email]',with: @user.email
      fill_in 'user[password]',with: '123456'
      click_on "Log in"
      page.should have_content("Add New Task")
    end

    scenario "Login and logout User", :js => true do
      @user = User.create(email: Faker::Internet.email,password: '123456')
      visit 'localhost:3000'
      fill_in 'user[email]',with: @user.email
      fill_in 'user[password]',with: '123456'
      click_on "Log in"
      page.should have_content("Add New Task")
      page.find('#logout',visible: false).click()
      page.should_not have_content("Add New Task")
    end
  end

end