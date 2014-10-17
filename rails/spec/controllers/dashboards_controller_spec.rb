require 'spec_helper'

describe DashboardsController do
  describe 'GET show' do
    it 'assigns @contacts in percentage order ASC' do
      user = create(:user)
      sign_in_as(user)
      old_contact = create(
        :contact,
        user: user)
      old_contact.stub(:goal_percentage).and_return(-50)
      new_contact = create(
        :contact,
        user: user
      )
      new_contact.stub(:goal_percentage).and_return(100)

      get :show

      expect(assigns(:contacts)).to eq [new_contact, old_contact]
    end
  end
end
