require 'rails_helper'

RSpec.describe Taging, type: :model do
 
  before(:each) do 
    p @user = build(:user)
    p @user1 = build(:user,email: "xyz@abc.com")
    p @task = build(:task,user_id: @user.id)
  end  
 
  it "is valid with valid attributes", :skip_before => true do
    @taging = build(:taging)
    expect(@taging).to be_valid 
  end

  [:user_id,:task_id].each do |attr|
    it {should respond_to "#{attr}"}
    it {should respond_to "#{attr}"}
  end

  describe Taging do
    it { expect(Taging.reflect_on_association(:user).macro).to eq(:belongs_to)}
    it { expect(Taging.reflect_on_association(:task).macro).to eq(:belongs_to)}
  end

  describe ".add_tag" do
    it "tag user in tasks created by other users" do
      Taging.add_tag(@user1.id,@task.id)
      p Taging.last
      expect(@task.tagings.pluck(:user_id)).to include(@user1.id.to_s)
    end
  end

  describe "#remove_tag" do
    it "removes tag if user is already tagged" do
      Taging.add_tag(@user1.id,@task.id)
      expect(@task.tagings.pluck(:user_id)).to include(@user1.id.to_s)
      @tag = Taging.find_by(user_id: @user1.id, task_id: @task.id)
      @tag.remove_tag
      expect(@task.tagings.pluck(:user_id)).not_to include(@user1.id.to_s)
    end
  end
  
end
