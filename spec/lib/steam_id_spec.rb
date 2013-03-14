require 'steam_id'

describe SteamID do

  it "#to_i converts to 64 bit style" do
    described_class.new('STEAM_0:1:24804711').to_i.
      should == 76561198009875151
  end

  it "#to_s converts to STEAM_X style" do
    described_class.new(76561198009875151).to_s.
      should == 'STEAM_0:1:24804711'
  end

end
