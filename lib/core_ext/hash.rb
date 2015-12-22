class Hash
  def get_by_keys *keys
    case keys.size
    when 0
      self
    when 1
      self[keys.first]
    else
      key = keys.shift
      if self.key?(key) && self[key].is_a?(Hash)
        self[key].get_by_keys(*keys)
      else
        nil
      end
    end
  end

  def set_by_keys keys, value
    key = keys.shift

    if keys.empty?
      self[key] = value
    else
      self[key] ||= {}
      self[key].set_by_keys keys, value
    end
  end

  def keys? *keys
    h = self
    keys.each_with_index do |key, i|
      if h.key? key
        unless i == (keys.size-1)
          return false unless h[key].is_a? Hash
          h = h[key]
        else
          return true
        end
      else
        return false
      end
    end
  end
end
