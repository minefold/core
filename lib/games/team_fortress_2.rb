require 'game'

module Games
  class TeamFortress2 < Game

    def default_access_policy
      PublicAccessPolicy
    end

    def available_access_policies
      [PublicAccessPolicy, TeamFortress2PasswordAccessPolicy]
    end

  end
end
