require 'rails_helper'

RSpec.describe Taging, type: :model do
  
  it "is valid with valid attributes" do
    @comment = Taging.create(user_id: 3,task_id: 10)
    expect(@comment).to be_valid 
  end

  describe 'Respond to fields' do
    it {should respond_to(:user_id)}
    it {should respond_to(:task_id)}
  end

  describe Taging do
    it { expect(Taging.reflect_on_association(:user).macro).to eq(:belongs_to)}
    it { expect(Taging.reflect_on_association(:task).macro).to eq(:belongs_to)}
  end

  describe ".add_tag" do
    it "tag user in tasks created by other users" do
      @user = User.create(email: "bc@gmail.com",password: 123456,name: "User1")
      @user1 = User.create(email: "bkl@gmail.com",password: 123456,name: "User2")
      @task = Task.create(user_id: @user.id,description: "Some Description")
      Taging.add_tag(@user1.id,@task.id,@user1.name)
      expect(@task.tagings.pluck(:user_id)).to include(@user1.id.to_s)
    end
  end

  it "removes tag if user is already tagged" do
      @user = User.create(email: "bci@gmail.com",password: 123456,name: "User1")
      @user1 = User.create(email: "bkli@gmail.com",password: 123456,name: "User2")
      @task = Task.create(user_id: @user.id,description: "Some Description")
      Taging.add_tag(@user1.id,@task.id,@user1.name)
      expect(@task.tagings.pluck(:user_id)).to include(@user1.id.to_s)
      @tag = Taging.find_by(user_id: @user1.id,task_id: @task.id)
      @tag.remove_tag
      expect(@task.tagings.pluck(:user_id)).not_to include(@user1.id.to_s)
  end


end
