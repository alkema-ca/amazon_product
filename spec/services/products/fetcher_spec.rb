require 'rails_helper'

RSpec.describe Products::Fetcher do
  subject { described_class.new(asin) }

  let(:page_request) { PageRequest.new(asin: asin, status: status, body: body) }

  context 'B002QYW8LW' do
    before do
      allow_any_instance_of(Amazon::Connection::Client).to receive(:get).and_return(response)
    end
    let(:response) { OpenStruct.new(body: body, status: status) }
    let(:client) { Amazon::Connection::Client.new }

    let(:body) { IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html")) }

    let(:asin) { 'B002QYW8LW' }
    let(:status) { 200 }

    it 'creates a product' do
      expect { subject.call }.to change { PageRequest.count }.from(0).to(1)
    end
  end

  context 'nil asin' do
    let(:asin) { nil }
    let(:status) { nil }
    let(:body) { nil }

    it 'creates a product' do
      expect { subject.call }.not_to change { PageRequest.count }.from(0)
    end
  end
end
