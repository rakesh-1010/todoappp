require "rails_helper"

RSpec.feature "Tagging other users in tasks", :type => :feature do

  feature "user1 creates task and tags user2" do
    scenario "User2 initials should show" , :js => true do
      @user = User.create(email: Faker::Internet.email,name: "Jigar",password: 123456)
      @user1 = User.create(email: Faker::Internet.email,name: "jigardatukda",password: 123456)
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
      select @user1.name,from: "#tag_user"
      page.should have_content(@user2.name.split("")[0])
    end
   
  scenario "User2 should be able to see tasks he is tagged in" , :js => true do
      @user = User.create(email: Faker::Internet.email,name: "Jigar",password: 123456)
      @user1 = User.create(email: Faker::Internet.email,name:"jigardatukda",password: 123456)
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
      select @user1.name,from: "#tag_user"
      page.should have_content(@user2.name.split("")[0])
      page.find("#logout").click
      fill_in "user[email]",with: @user2.email
      fill_in "user[password]",with: 123456 
      click_on 'Log in'
      page.should have_content("Some Description")
    end
 end 
end
