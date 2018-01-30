require 'rails_helper'

RSpec.describe Tag, type: :model do

  before(:each) do
    @user = build(:user)
    @user1 = build(:user,email: "xyz@abc.com")
    @task = build(:task,user_id: @user.id)
  end

  it "is valid with valid attributes", :skip_before => true do
    @tag = create(:tag)
    expect(@tag).to be_valid
  end

  [:user_id,:task_id].each do |attr|
    it {should respond_to "#{attr}"}
    it {should respond_to "#{attr}"}
  end

  it { expect(Tag.reflect_on_association(:user).macro).to eq(:belongs_to)}
  it { expect(Tag.reflect_on_association(:task).macro).to eq(:belongs_to)}

end
