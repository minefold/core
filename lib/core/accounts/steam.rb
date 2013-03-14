require 'core/account'
require 'core/steam_id'

module Core
  module Accounts
    class Steam < Core::Account

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
end
