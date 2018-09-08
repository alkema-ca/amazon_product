# A service class that converts Regex named captures into a simple Hash
class MatchHash

  def self.call(match)
    Hash[match.names.zip(match.captures)].symbolize_keys
  end

end
