require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        :description => "Description",
        :is_completed => false,
        :user_id => 2
      ),
      Task.create!(
        :description => "Description",
        :is_completed => false,
        :user_id => 2
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
