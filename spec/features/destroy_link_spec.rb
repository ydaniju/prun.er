# frozen_string_literal: true
require 'rails_helper'
describe 'the link deletion process', type: :feature do
  before :each do
    sign_up_with 'omonla', 'valid@example.com', 'password', 'password'
  end

  it 'deletes link' do
    within '.field1' do
      find('input').set 'www.userexample.com'
    end
    click_button 'Prune Me'
    first('.card').click_link 'Delete'
    expect(page).to have_content 'Link successfully destroyed'
  end
end
