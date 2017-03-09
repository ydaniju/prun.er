# frozen_string_literal: true
require 'rails_helper'
describe 'the signin process', type: :feature do
  before :each do
    sign_up_with 'omonla', 'valid@example.com', 'password', 'password'
  end

  it 'signs me in if entry is valid' do
    click_link 'Sign Out'
    sign_in_with('valid@example.com', 'password')
    expect(page).to have_content 'Welcome'
  end

  it "doesn't signs me in if entry is invalid" do
    click_link 'Sign Out'
    sign_in_with('valid@example.com', 'passworde')
    expect(page).to have_content 'Invalid'
  end

  it 'links to signup page' do
    visit '/sessions/new'
    click_link 'Please Sign Up'
    expect(page).to have_content 'If you got an account, please Sign In'
  end
end
