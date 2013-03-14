class SteamID
  BASE_64_MASK = 0x0110000100000000

  def initialize(raw)
    @raw = raw
  end

  def to_i
    if @raw =~ /^STEAM/
      _, y, z = @raw.split(':').map(&:to_i)
      (z * 2) + BASE_64_MASK + y
    else
      Integer(@raw)
    end
  end

  def to_s
    w = to_i - BASE_64_MASK
    parity = w % 2
    "STEAM_0:#{parity}:#{w / 2}"
  end

end
