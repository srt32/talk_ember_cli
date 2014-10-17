require 'spec_helper'

feature 'User adds a contact' do

  scenario 'with valid name and frequency' do
    create_and_sign_in
    visit root_path
    fill_in 'Name', with: 'Nick'
    select('Weekly', :from => 'Frequency')
    click_on 'Add'
    expect(page).to have_content("added Nick")
    expect(page).to have_content('Nick')
    expect(page).to have_content(7)
  end

end
