require "rails_helper"

RSpec.describe "Auth", type: :routing do

  describe "routing" do

    it "routes to #sign_in" do
      expect(post: user_session_path).to route_to("devise_token_auth/sessions#create")
    end


    it "routes to #sign_up" do
      expect(post: user_registration_path).to route_to("devise_token_auth/registrations#create")
    end

  end
end
