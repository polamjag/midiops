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

      def parse_note note
        # formats to accept: "C3" / "B-1" / "C#4" (sharp) / "Db5" (flat)

        case note
        when /^([A-Ga-g])(-?[0-9]{1,2})$/
          m = $~.captures
          {key: m[0].upcase.to_sym, octave: m[1].to_i}
        when /^([CDFGAcdfga])\#(-?[0-9]{1,2})$/
          m = $~.captures
          {key: "#{m[0].upcase}sharp".to_sym, octave: m[1].to_i}
        when /^([DEGABdegab])b(-?[0-9]{1,2})$/
          m = $~.captures
          {key: "#{m[0].upcase}flat".to_sym, octave: m[1].to_i}
        else
          raise RuntimeError, "Invalid note format: #{note}"
        end
      end

      def note_to_code note
        res = parse_note note
        key_to_code res[:key], res[:octave]
      end
    end
  end
end
