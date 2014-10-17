require 'spec_helper'

describe Conversation do
  it { should validate_presence_of(:contact_id) }
end
