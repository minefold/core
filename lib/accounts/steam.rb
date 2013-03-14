require 'account'
require 'steam_id'

module Accounts
  class Steam < Account

    def profile_url
      URI::HTTPS.build(
        host: 'steamcommunity.com',
        path: "/profile/#{uid}"
      )
    end

    def steam_id
      SteamID.new(uid)
    end

  end
end
