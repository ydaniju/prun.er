# frozen_string_literal: true
require 'rails_helper'
describe 'the link redirection process', type: :feature do
  before :each do
    sign_up_with 'omonla', 'valid@example.com', 'password', 'password'
  end

  it 'redirects to original url' do
    within '.field1' do
      find('input').set 'www.facebook.com'
    end
    within '.field2' do
      find('input').set 'face'
    end
    click_button 'Prune Me'
    visit "#{root_url}/face"

    expect(current_url).to have_content 'facebook.com'
  end

  it 'gives error when when url is destroyed' do
    within '.field1' do
      find('input').set 'www.facebook.com'
    end
    within '.field2' do
      find('input').set 'face'
    end
    click_button 'Prune Me'
    first('.card').click_link 'Delete'
    visit "#{root_url}/face"

    expect(page).to have_content 'Link must have been destroyed'
  end
end
