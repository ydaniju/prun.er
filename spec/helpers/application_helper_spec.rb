# frozen_string_literal: true
RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    it 'returns base_title if no page_title' do
      page_title = ''
      expect(full_title(page_title)).to eq ' - for the finest of links'
    end

    it 'returns full if page_title is given' do
      page_title = 'Home'
      expect(full_title(page_title)).to have_content 'Home'
    end
  end
end
