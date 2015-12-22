require 'spec_helper'

describe Hash do
  before do
    @hashes = [
      {
        hash: {
          a: {
            b: {
              c: {
                d: 1
              }
            }
          }
        },
        get_target: [:a, :b, :c, :d],
        get_value: 1,
        get_target_ne: [:a, :b, :c, :d, :e],
        set_target: [:a, :b, :piyo, :hoge],
        set_val: :fuga,
        set_result: {
          a: {
            b: {
              c: {
                d: 1
              },
              piyo: {
                hoge: :fuga
              }
            }
          }
        },
      },
      {
        hash: {
          a: {
            b: {
              c: {
                d: 1,
                e: 2
              }
            },
            c: 3
          }
        },
        get_target: [:a, :b, :c, :d],
        get_value: 1,
        get_target_ne: [:a, :b, :c, :d, :e],
        set_target: [:bar],
        set_val: :foo,
        set_result: {
          a: {
            b: {
              c: {
                d: 1,
                e: 2
              }
            },
            c: 3
          },
          bar: :foo
        }
      },
    ]
  end

  describe '#get_by_keys' do
    it 'works for key which exists' do
      @hashes.each do |h|
        expect(h[:hash].get_by_keys(*h[:get_target])).to eq h[:get_value]
      end
    end

    it 'returns nil for key which does not exists (a)' do
      @hashes.each do |h|
        expect(h[:hash].get_by_keys(*h[:get_target_ne])).to eq nil
      end
    end

    it 'returns nil for key which does not exists (b)' do
      @hashes.each do |h|
        expect(h[:hash].get_by_keys(:key, :which, :does, :not, :exists)).to eq nil
      end
    end
  end

  describe '#set_by_keys' do
    it 'works' do
      @hashes.each do |h|
        h_mod = h[:hash]
        h_mod.set_by_keys(h[:set_target], h[:set_val])

        expect(h_mod).to eq h[:set_result]
      end
    end
  end

  describe '#keys?' do
  end
end
