require 'rails_helper'

RSpec.describe UserChannel, type: :channel do

  let(:current_user){
    create(:user)
  }

  before(:each) do
    allow(ActionCable.server).to receive(:broadcast)
    stub_connection current_user: current_user
    subscribe
  end
  
  it "successfully subscribes" do
    expect(subscription).to be_confirmed
  end

end
