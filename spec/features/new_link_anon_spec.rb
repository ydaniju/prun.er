# frozen_string_literal: true
require 'rails_helper'
describe 'the link creation process', type: :feature do
  it 'creates new link without vanity string' do
    visit '/'
    within '.field' do
      find('input').set 'www.userexample.com'
    end
    click_button 'Prune Me'
    expect(page).to have_content 'less than a minute ago'
  end

  it 'rejects bad urls for without vanity string' do
    visit '/'
    within '.field' do
      find('input').set 'user@example.com'
    end
    click_button 'Prune Me'
    expect(page).to have_content 'Mobile Friendly'
  end
end
