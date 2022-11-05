require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do
  it "successfully connects", only: true do
    user = create(:user)
    auth_params = user.create_new_auth_token
    connect "/cable", params: {
        uid: user.email,
        token: auth_params["access-token"],
        client: auth_params["client"],
    }
    expect(connection.current_user.id).to eq 1
  end

  it "rejects connection" do
    expect { connect "/cable" }.to have_rejected_connection
  end

end
