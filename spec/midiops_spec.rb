require 'spec_helper'

describe MIDIOps do
  it 'has a version number' do
    expect(MIDIOps::VERSION).not_to be nil
  end

  describe MIDIOps::Note do
    context 'valid notes' do
      it 'can parse B4' do
        expect(MIDIOps::Note.parse_note "B4").to eq({key: :B, octave: 4})
      end

      it 'can parse A-1' do
        expect(MIDIOps::Note.parse_note "A-1").to eq({key: :A, octave: -1})
      end

      it 'can parse C#2' do
        expect(MIDIOps::Note.parse_note "C#2").to eq({key: :Csharp, octave: 2})
      end

      it 'can parse Db2' do
        expect(MIDIOps::Note.parse_note "Db2").to eq({key: :Dflat, octave: 2})
      end
    end

    context 'invalid notes' do
      it 'raises error for H3' do
        expect {MIDIOps::Note.parse_note "H3"}.to raise_error(RuntimeError)
      end

      it 'raises error for Cb3' do
        expect {MIDIOps::Note.parse_note "Cb3"}.to raise_error(RuntimeError)
      end

      it 'raises error for E#3' do
        expect {MIDIOps::Note.parse_note "E#3"}.to raise_error(RuntimeError)
      end
    end
  end
end
