require "spec_helper"

describe ConversationsController do
  describe "Creating a new conversation" do
    context "with valid attributes" do
      it "creates a new conversation" do
        contact = create(:contact)
        attributes = { contact_id: contact.id }

        post api_conversations_path, { conversation: attributes }

        expect(response.status).to eq 201
      end
    end
  end
end
