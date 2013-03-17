require 'server_access_policy'

module ServerAccessPolicies
  class Public < ServerAccessPolicy

    def data
      server.settings['sv_password']
    end

  end
end
