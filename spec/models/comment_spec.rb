require 'rails_helper'

RSpec.describe Comment, type: :model do

  it "is valid with valid attributes" do
    @comment = Comment.create(comment: 'some comment',user_id: 3,task_id: 10)
    expect(@comment).to be_valid 
  end

  it "is invalid without comment attribute" do
    expect(Comment.create(comment: nil)).to_not be_valid
  end

  describe 'Respond to fields' do
    it {should respond_to(:comment)}
    it {should respond_to(:user_id)}
    it {should respond_to(:task_id)}
  end

  describe Comment do
    it { expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)}
    it { expect(Comment.reflect_on_association(:task).macro).to eq(:belongs_to)}
  end

end
