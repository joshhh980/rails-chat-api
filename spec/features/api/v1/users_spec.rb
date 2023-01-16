require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do

  let(:current_user){
    create(:user)
  }
  
  describe "#index" do

    it "fetches users" do
        current_user
        token = current_user.create_new_auth_token
        another_user = create(:user, email: "anotheruser@mail.com")
        @expected = [{
          id: 2,
          name: another_user.name,
          image: another_user.image,
        }].to_json
        get api_v1_users_path, headers: token
        response.body.should == @expected
    end

  end

end