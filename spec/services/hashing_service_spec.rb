require "rails_helper"
RSpec.describe HashingService do

  describe '#encode' do
    context 'when encoding' do
      subject(:hashing) { HashingService.instance.encode(1) }
      it { is_expected.to eq "E8" }
      it 'can decode' do
        expect(HashingService.instance.decode(hashing)[0]).to eq 1
      end
    end
  end

  describe '#decode' do
    context 'when decoding' do
      subject { HashingService.instance.decode("E8")[0] }
      it { is_expected.to eq 1 }
    end
  end

end