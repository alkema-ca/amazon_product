require 'rails_helper'

RSpec.describe MatchHash do
  let(:call) { described_class.call(match) }

  let(:match) do
    phone.match(/(?<area>\d{3})-(?<city>\d{3})-(?<number>\d{4})/)
  end

  let(:phone) { '555-333-7777' }

  describe '.call' do
    it 'returns a hash with symbolized given from matched captures' do
      expect(call).to eq(area: '555', city: '333', number: '7777')
    end
  end
end
