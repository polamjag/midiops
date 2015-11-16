module MIDIOps
  module Note
    KEY_OFFSETS = {
      C: 0,

      Csharp: 1,
      Dflat: 1,

      D: 2,

      Dsharp: 3,
      Eflat: 3,

      E: 4,

      F: 5,

      Fsharp: 6,
      Gflat: 6,

      G: 7,

      Gsharp: 8,
      Aflat: 8,

      A: 9,

      Asharp: 10,
      Bflat: 10,

      B: 11
    }

    class << self
      def key_to_code key, octave
        KEY_OFFSETS[key] + 12 + (12 * octave)
      end
    end
  end
end
