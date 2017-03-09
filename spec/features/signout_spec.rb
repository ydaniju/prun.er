# frozen_string_literal: true
require 'rails_helper'
describe 'the signout process', type: :feature do
  before :each do
    sign_up_with 'omonla', 'valid@example.com', 'password', 'password'
  end

  it 'signs me in if entry is valid' do
    click_link 'Sign Out'
    expect(page).to have_content 'Mobile Friendly'
  end
end
