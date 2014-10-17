class Contact < ActiveRecord::Base
  validates :frequency, inclusion: { in: (1..365) }
  validates :frequency, numericality: true
  validates :frequency, numericality: { only_integer: true }
  validates :frequency, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :user_id, presence: true

  has_many :conversations
  belongs_to :user

  def last_conversation_days_ago
    unless last_conversation.created_at == 0
      seconds = Time.now.utc - last_conversation.created_at.utc
      days = seconds / (60 * 60 * 24)
      days.round
    else
      0
    end
  end

  def goal_percentage
    100 - ((last_conversation_days_ago.to_f / frequency) * 100).round
  end

  private

  def last_conversation
    conversations.order("created_at DESC").limit(1).first || NoConversation.new
  end
end

class NoConversation
  def created_at
    Time.now
  end
end
