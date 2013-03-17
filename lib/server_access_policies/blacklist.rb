require 'server_access_policy'

module ServerAccessPolicies
  class Blacklist < ServerAccessPolicy

    def data
      (server.settings['blacklist'] || '').split("\r\n")
    end

  end
end
