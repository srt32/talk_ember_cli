require 'spec_helper'

describe Contact do
  it { should validate_presence_of(:frequency) }
  it { should ensure_inclusion_of(:frequency).in_range(1..365) }
  it { should validate_numericality_of(:frequency).only_integer }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  it { should validate_presence_of(:user_id) }

  it { should belong_to(:user) }
  it { should have_many(:conversations) }

  describe "#last_conversation_days_ago" do
    it 'should return number of days ago as 0 for recent conversation' do
      contact = create(:contact)
      old_conversation = create(:conversation,
                                contact: contact,
                                created_at: 10.days.ago)
      recent_conversation = create(:conversation,
                                   contact: contact)
      expect(contact.last_conversation_days_ago).to eq(0)
    end

    it 'should return number of days ago as >0 for old conversation' do
      contact = create(:contact)
      old_conversation = create(:conversation,
                                contact: contact,
                                created_at: 10.days.ago)
      recent_conversation = create(:conversation,
                                   contact: contact,
                                   created_at: 5.days.ago)
      expect(contact.last_conversation_days_ago).to eq(5)
    end
  end
end

describe Contact, '#goal_percentage' do
  it 'should return percentage of frequency since last conversation' do
    contact = create(:contact, frequency: 30)
    create(
      :conversation,
      contact: contact,
      created_at: 15.days.ago
    )

    percentage = contact.goal_percentage

    expect(percentage).to eq 50
  end
end
