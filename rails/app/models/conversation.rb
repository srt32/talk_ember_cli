class Conversation < ActiveRecord::Base
  validates :contact_id, presence: true

  belongs_to :contact
end
