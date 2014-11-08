require "spec_helper"

describe Api::SessionsController do
  describe "Logging in" do
    context "with valid credentials" do
      it "returns 200 with the user's token" do
        password = "mypassword"
        user = create(:user, password: password)
        attributes = { email: user.email, password: password }

        post api_sessions_path, { session: attributes }

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["users"][0]["email"]).to eq user.email
        expect(JSON.parse(response.body)["users"][0]["token"]).to eq user.token
      end
    end

    context "with invalid credentials" do
      it "returns 401" do
        password = "mypassword"
        fake_password = "mean_hacker"
        user = create(:user, password: password)
        attributes = { email: user.email, password: fake_password }

        post api_sessions_path, { session: attributes }

        expect(response.status).to eq 401
      end
    end
  end
end
