class User < ActiveRecord::Base
  include Clearance::User

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
end
