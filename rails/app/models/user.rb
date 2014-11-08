class User < ActiveRecord::Base
  include Clearance::User
  before_create :generate_access_token

  has_many :contacts

  def overall_percentage
    if contacts.present?
      raw_overall_percentage.round
    else
      100
    end
  end

  private

  def raw_overall_percentage
    contacts.map(&:goal_percentage).inject(:+) / contacts.size
  end

  def generate_access_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end
end
