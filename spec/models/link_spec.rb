# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:link) do
    build(:link)
  end
  context 'when initialized' do
    it 'should have url_input attribute' do
      expect(link.url_input.class).to be String
    end

    it 'rejects wrong url_input' do
      link.url_input = 'www@gmail.com'
      expect(link).to be_invalid
    end
  end
end
