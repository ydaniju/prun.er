# frozen_string_literal: true
require 'rails_helper'
describe 'the link edit process', type: :feature do
  before :each do
    sign_up_with 'omonla', 'valid@example.com', 'password', 'password'
  end

  it 'change target and status of link' do
    sign_in_with('valid@example.com', 'password')

    within '.field1' do
      find('input').set 'www.validexample.com'
    end
    click_button 'Prune Me'
    click_link 'Link Details'
    fill_in 'Change Url', with: 'http://facebook.come'
    click_button 'Update'

    expect(page).to have_content 'Link updated'
  end

  it "changes nothing if data of link isn't changed" do
    sign_in_with('valid@example.com', 'password')

    within '.field1' do
      find('input').set 'www.validexample.com'
    end
    click_button 'Prune Me'
    click_link 'Link Details'
    click_button 'Update'

    expect(page).to have_content 'No changes made'
  end
end
