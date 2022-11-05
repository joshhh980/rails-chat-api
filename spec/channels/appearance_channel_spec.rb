require 'rails_helper'

RSpec.shared_examples "broadcasts status" do |action|

  it "broadcasts " + action + " and current_user.id" do
    expect(ActionCable.server).to have_received(:broadcast).with("appearance", {
      :action => action,
      :user_id => current_user.id,
    })
  end

end

RSpec.shared_examples "updates status" do |action|

  it "updates current_user status to " + action do
    user = User.find(current_user.id)
    expect(user.status).to eq(action)
  end

end


RSpec.describe AppearanceChannel, type: :channel do

  let(:current_user){
    create(:user)
  }
  
  it "successfully subscribes" do
    subscribe
    expect(subscription).to be_confirmed
  end

  describe "#appear" do

    before(:each) do
      allow(ActionCable.server).to receive(:broadcast)
      stub_connection current_user: current_user
      subscribe
      perform :appear
    end

    include_examples "broadcasts status", "appear"

    include_examples "updates status", "online"
    
  end

  describe "#unsubscribed" do

    before(:each) do
      stub_connection current_user: current_user
      allow(ActionCable.server).to receive(:broadcast)
      subscribe
      unsubscribe
    end

    include_examples "broadcasts status", "away"

    include_examples "updates status", "offline"
    
  end

end
