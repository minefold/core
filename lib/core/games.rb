require 'core/games/minecraft'
require 'core/games/team_fortress_2'

require 'core/game_library'

module Core

  Games = Core::GameLibrary.new([
    Core::Games::Minecraft.new(
      id: 1,
      name: 'Minecraft',
      slug: 'minecraft',
      funpack_id: 1,
      published_at: DateTime.new(2011, 4, 1),
      url: 'https://minecraft.net/store'
    ),
    Core::Games::TeamFortress2.new(
      id: 2,
      name: 'Team Fortress 2',
      slug: 'team-fortress-2',
      funpack_id: 4,
      published_at: DateTime.new(2012, 2, 8),
      url: 'http://store.steampowered.com/app/440'
    )
  ])

end
