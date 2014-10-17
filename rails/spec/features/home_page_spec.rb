require 'spec_helper'

feature 'On the homepage' do

  scenario 'before signing in sent to log in' do
    visit root_path
    expect(page).to have_content('Sign in')
  end

  scenario 'after signing in user sees dashboard' do
    create_and_sign_in
    expect(page).to have_content('Your Contacts')
  end

  scenario 'shows percentage by contact' do
    user = create_and_sign_in
    contact = create(:contact, user: user, frequency: 30)
    create(
      :conversation,
      contact: contact,
      created_at: 15.days.ago
    )

    visit root_path

    expect(page).to have_content('50')
  end
end
