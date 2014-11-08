require "spec_helper"

describe ContactsController do
  describe "Creating a new contact" do
    context "with valid attributes" do
      it "creates a new contact" do
        user = create(:user)
        attributes = attributes_for(:contact, user: user)

        expect {
          post api_contacts_path, { contact: attributes }
        }.to change { user.contacts.count }.by(1)

        expect(response.status).to eq 201
      end
    end
  end
end
