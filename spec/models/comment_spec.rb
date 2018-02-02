require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) { @comment = build(:comment) }
  it "is valid with valid attributes" do
    expect(@comment).to be_valid 
  end

  it "is invalid without comment attribute" do
    expect(Comment.create(comment: nil)).to_not be_valid
  end
  
  [:comment,:user_id,:task_id].each do |attribute|
    it {should respond_to "#{attribute}"}
  end

  describe Comment do
    it { expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)}
    it { expect(Comment.reflect_on_association(:task).macro).to eq(:belongs_to)}
  end
end
