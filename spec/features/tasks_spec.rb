require "rails_helper"

RSpec.feature "Task Flow", :type => :feature do

  feature "Actions on Task" do
    scenario "Create new task" , :js => true do
      @user = User.create(email: Faker::Internet.email,password: '123456')
      visit 'localhost:3000'
      fill_in user[email],with: @user.email
      fill_in user[password],with: '123456'
      click_on 'Log in'
      click_on "Add New task"
      fill_in 'task[description]',with: "Some Description"
      click_on 'Create'
      page.should have_content("Some Description")
    end

    scenario "Edit task", :js => true do
      @user = User.create(email: Faker::Internet.email,password: '123456')
      visit 'localhost:3000'
      fill_in user[email],with: @user.email
      fill_in user[password],with: '123456'
      lick_on 'Log in'
      click_on "Add New task"
      fill_in 'task[description]',with: "Some Description"
      click_on 'Create'
      page.find(".fa fa-edit").click()
      fill_in 'task[description]',with: "Modified Description"
      clcik_on "Create"
      page.should have_content("Modified Description")
    end

    scenario "Delete task",:js => true do
      @user = User.create(email: Faker::Internet.email,password: '123456')
      visit 'localhost:3000'
      fill_in user[email],with: @user.email
      fill_in user[password],with: '123456'
      click_on 'Log in'
      click_on "Add New task"
      fill_in 'task[description]',with: "Some Description"
      click_on 'Create'
      page.should have_content("Some Description")
      page.find(".fa fa-trash").click()
      click_on "OK"
      sleep 1
      page.should_not have_content("Modified Description")
    end
  end
end