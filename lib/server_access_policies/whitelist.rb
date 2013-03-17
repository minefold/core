require 'server_access_policy'

module ServerAccessPolicies
  class Whitelist < ServerAccessPolicy

    def data
      (server.settings['whitelist'] || '').split("\r\n")
    end

  end
end
