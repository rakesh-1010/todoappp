require 'rails_helper'

RSpec.describe Task, type: :model do

  it "is valid with valid attributes" do
    @user = User.last
    expect(Task.new(description: "New Task",user_id: @user,is_completed: false)).to be_valid
  end

  it "is not valid without a description" do
    task = Task.new(description: nil)
    expect(task).to_not be_valid
  end

  [:description,:is_completed,:user_id].each do |attr|
    it { should respond_to "#{attr}"}
  end

  describe Task do
    it { expect(Task.reflect_on_association(:user).macro).to eq(:belongs_to) }
    it { expect(Task.reflect_on_association(:tags).macro).to eq(:has_many) }
  end

  describe "#tagged_used_ids" do
    it "should return array of user_ids of all tagged users in a task" do
      create_tasks_and_users
      @task2.tag(@user)
      expect(@task2.tagged_user_ids).to eq([@user.id.to_s])
    end

  end

  describe "#tag_exists_for" do

    it "should return true if tag exist for user" do
      create_tasks_and_users
      @task2.tag(@user)
      expect(@task2.tag_exists_for(@user)).to be true
    end

    it "should return false if tag does not exist for passed user" do
      create_tasks_and_users
      @task2.tag(@user)
      expect(@task2.tag_exists_for(@user2)).to be false
    end

  end

  describe "tag" do
    it "should tag user in task" do
      create_tasks_and_users
      @task2.tag(@user)
      expect(@task2.tag_exists_for(@user)).to be true
    end
  end

  describe "untag" do
    it "should untag user from task" do
      create_tasks_and_users
      @task2.tag(@user)
      @task2.untag(@user)
      expect(@task2.tag_exists_for(@user)).to be false 
    end  
  end
  
  describe "#toggle_tag" do
    context "when user is already tagged in task" do
      it "should untag user from task" do
        create_tasks_and_users
        @task2.tag(@user)
        @task2.toggle_tag(@user)
        expect(@task2.tag_exists_for(@user)).to be false
      end
    end

    context "when user is not tagged in task" do
      it  "should tag user to task" do
        create_tasks_and_users
        @task2.toggle_tag(@user)
        expect(@task2.tag_exists_for(@user)).to be true
      end
    end
  end

  private

  def create_tasks_and_users
    @user = User.create(email:"asd@jaka.com",password: 123456,name: "user1")
    @task1 = @user.tasks.create(description: "some description")
    @user2 = User.create(email:"user2@jaka.com",password: 123456,name: "user2")
    @task2 = @user2.tasks.create(description: "some other task")
  end

end
