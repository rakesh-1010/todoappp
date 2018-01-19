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
    it { expect(Task.reflect_on_association(:tagings).macro).to eq(:has_many) }
  end


end
