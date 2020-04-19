require 'rails_helper'

RSpec.describe MinifiedLink, type: :model do
  context 'validations' do
    subject { described_class.new(original_url: 'www.sapo.pt') }

    context 'is valid' do
      it "with valid attributes" do
        expect(subject).to be_valid
      end

      it "with params" do
        subject.original_url = 'https://google.pt/?a=1'
        expect(subject).to be_valid
      end

      it "with subdomain" do
        subject.original_url = 'subdominio.google.pt'
        expect(subject).to be_valid
      end

      it "with 2 parts url" do
        subject.original_url = 'subdominio.google.pt/?a=1#x=z'
        expect(subject).to be_valid
      end

      it "with a diferent port" do
        subject.original_url = 'https://www.sapo.pt:3000/'
        expect(subject).to_not be_valid
      end
    end

    context 'is invalid' do

      it "without a minified_link" do
        subject.original_url = nil
        expect(subject).to_not be_valid
      end

      it "with an invalid url, starting with http" do
        subject.original_url = 'httpaaa'
        expect(subject).to_not be_valid
      end

      it "with an url witdout domain " do
        subject.original_url = 'aaa'
        expect(subject).to_not be_valid
      end

      it "with an url an long domain " do
        subject.original_url = 'aaa.pppppp'
        expect(subject).to_not be_valid
      end

      it "with an url with javascript " do
        subject.original_url = 'javascript:alert("hi");'
        expect(subject).to_not be_valid
      end
    end

  end

  describe '#original_url' do
    subject { described_class.new(original_url: 'www.sapo.pt') }
    before { subject.valid? }

    context 'filled  without protocol' do
      it 'returns a full url, with http' do
        expect(subject.original_url).to eq('http://www.sapo.pt')
      end
    end

    context 'filled with protocol' do
      it 'http keeps a full url' do
        subject.original_url = 'http://www.sapo.pt'
        expect(subject.original_url).to eq('http://www.sapo.pt')
      end

      it 'https keeps a full url' do
        subject.original_url = 'https://www.sapo.pt'
        expect(subject.original_url).to eq('https://www.sapo.pt')
      end
    end

  end

  describe '.search_by_url_key' do
    before {described_class.create!(original_url: 'https://www.sapo.pt') }
    context 'with valid params' do
      it 'finds the record by key' do
        record = described_class.last
        expect(described_class.search_by_url_key(HashingService.instance.encode(record.id)).id).to eq(record.id)
      end
    end
  end
end
