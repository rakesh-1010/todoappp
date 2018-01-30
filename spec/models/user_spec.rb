require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    expect(User.new(email: "xyz@abc.com",password: "123456")).to be_valid
  end

  it "is not valid without a valid email" do
    user = User.new(email: nil)
    expect(user).to_not be_valid
    user1 = User.new(email: "saas.asas.com")
    expect(user1).to_not be_valid
  end

  it "is not valid without a valid password" do
    user = User.new(email:"asd@jaka.com",password: nil)
    expect(user).to_not be_valid
    user1 = User.new(email:"asd@jaka.com",password: "12345")
    expect(user1).to_not be_valid
  end

  [:name,:email,:password].each do |attr| 
    it { should respond_to "#{attr}"}
  end

  it { expect(User.reflect_on_association(:tasks).macro).to eq(:has_many) }
  it { expect(User.reflect_on_association(:tags).macro).to eq(:has_many) }

  describe "#tagged_tasks" do
    it "returns array of tasks user is tagged in" do
     create_task_and_tag_user
     expect(@user.tagged_tasks).to eq([@task2])
    end

  end

  describe "#all_tasks" do
    it "return array of all tasks created by user and tasks in which he is tagged" do
     create_task_and_tag_user
     expect(@user.all_tasks).to eq([@task1,@task2])
    end

  end
  
  private

  def create_task_and_tag_user
    @user = User.create(email:"asd@jaka.com",password: 123456,name: "user1")
    @task1 = @user.tasks.create(description: "some description")
    @user2 = User.create(email:"user2@jaka.com",password: 123456,name: "user2")
    @task2 = @user2.tasks.create(description: "some other task")
    @task2.tag(@user)
  end
end
