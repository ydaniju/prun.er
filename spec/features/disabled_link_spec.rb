# frozen_string_literal: true
require 'rails_helper'
describe 'the link disabling process', type: :feature do
  before :each do
    sign_up_with 'omonla', 'valid@example.com', 'password', 'password'
  end

  it 'disables a link' do
    sign_in_with('valid@example.com', 'password')

    within '.field1' do
      find('input').set 'www.validexample.com'
    end
    within '.field2' do
      find('input').set 'mmm'
    end
    click_button 'Prune Me'
    click_link 'Link Details'
    find(:css, "#false_status[value='false']").set(false)
    click_button 'Update'
    visit "#{root_url}/mmm"
    expect(page).to have_content 'Link is disabled'
  end
end
