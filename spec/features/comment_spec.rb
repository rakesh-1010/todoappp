require "rails_helper"

RSpec.feature "adding comments to tasks", :type => :feature do

  feature "user1 creates task and can add comments" do
    scenario "Added Comments should show in the show task modal" , :js => true do
      @user = User.create(email: Faker::Internet.email,name: "Jigar",password: 123456)
      visit 'localhost:3000'
      fill_in "user[email]",with: @user.email
      sleep 2
      fill_in "user[password]",with: 123456
      sleep 2
      click_on 'Log in'
      click_on "Add New task"
      fill_in 'task[description]',with: "Some Description"
      click_on 'Save'
      click_on 'Some Description'
      fill_in "comment[comment]",with: "Some Comments"
      click_on 'Save'
      page.should have_content("Some Comment")
    end
   
    scenario "User2 should be able to see tasks he is tagged in" , :js => true do
       @user = User.create(email: Faker::Internet.email,name: "Jigar",password: 123456)
      visit 'localhost:3000'
      fill_in "user[email]",with: @user.email
      sleep 2
      fill_in "user[password]",with: 123456
      sleep 2
      click_on 'Log in'
      click_on "Add New task"
      fill_in 'task[description]',with: "Some Description"
      click_on 'Save'
      click_on 'Some Description'
      fill_in "comment[comment]",with: "Some Comments"
      click_on 'Save'
      page.should have_content("Some Comment") 
      page.find("i.fa.fa-trash").click
      page.should_not have_content("Some Comment") 
    end
 end 
end
