require 'core/version'
require 'core/redis'

require 'account'
require 'accounts'
require 'activity_stream'
require 'bonus'
require 'funpack'
require 'game_library'
require 'game'
require 'games'
require 'map'
require 'personal_name'
require 'player_session'
require 'product'
require 'redis_key'
require 'serializer'
require 'server_address'
require 'server_session'
require 'server'
require 'snapshot'
require 'steam_id'
require 'user'

module Core

  GAMES = GameLibrary.new([
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
