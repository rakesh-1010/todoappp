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

  describe User do
    it { expect(User.reflect_on_association(:tasks).macro).to eq(:has_many) }
    it { expect(User.reflect_on_association(:tagings).macro).to eq(:has_many) }
  end
end
