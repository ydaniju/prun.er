# frozen_string_literal: true
require 'rails_helper'
describe 'the link creation process', type: :feature do
  before :each do
    sign_up_with 'omonla', 'valid@example.com', 'password', 'password'
  end

  context 'without vanity' do
    it 'creates new link without vanity string when signed in' do
      within '.field1' do
        find('input').set 'www.userexample.com'
      end
      click_button 'Prune Me'
      expect(page).to have_content 'You have 1 pruned link'
    end
  end

  context 'with vanity' do
    it 'creates new link with vanity string when signed in' do
      within '.field1' do
        find('input').set 'www.userexample.com'
      end
      within '.field2' do
        find('input').set 'mmm'
      end
      click_button 'Prune Me'
      expect(page).to have_content 'mmm'
    end
  end

  context 'wrong entry' do
    it 'rejects new link with vanity string and wrong entry' do
      within '.field1' do
        find('input').set 'www@userexample.com'
      end
      within '.field2' do
        find('input').set 'mmm'
      end
      click_button 'Prune Me'
      expect(page).to have_content 'create one with the form above'
    end
  end
end
