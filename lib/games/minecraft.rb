require 'game'
require 'accounts/mojang'

module Games
  class Minecraft < Game

    def auth?
      true
    end

    def split_billing?
      true
    end

    def static_address?
      true
    end

    def mappable?
      true
    end

    # TODO Untested
    def account_provider
      Accounts::Mojang
    end

    # def default_access_policy
    #   MinecraftBlacklistAccessPolicy
    # end
    #
    # def available_access_policies
    #   [MinecraftBlacklistAccessPolicy, MinecraftWhitelistAccessPolicy]
    # end

  end
end
