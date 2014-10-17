require 'spec_helper'

describe User do
  describe "Contacts association" do
    it { should have_many(:contacts) }
  end

  describe "#overall_percentage" do
    context "with no contacts" do
      it "returns 100" do
        user = create(:user)

        score = user.overall_percentage

        expect(score).to eq 100
      end
    end

    context "with contacts" do
      it "returns average of goal_percentages" do
        user = create(:user)
        _up_to_date_contact = create(:contact, user: user)
        overdue_contact = create(:contact, user: user, created_at: 7.days.ago)
        create(:conversation, created_at: 7.days.ago, contact: overdue_contact)

        score = user.overall_percentage

        expect(score).to eq 50
      end
    end
  end
end
