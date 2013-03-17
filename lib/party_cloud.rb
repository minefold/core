class PartyCloud

  def self.start_server_session(server_id, session_id, data)
    sleep rand(5)
    t = Time.now
    puts "Server##{server_id} started session #{session_id} at #{t}"
    {at: t, ip: '127.0.0.1', port: 5000}
  end

  def self.stop_server_session(server_id, session_id)
    sleep rand(5)
    t = Time.now
    puts "Server##{server_id} stopped at #{t}"
    {at: t}
  end

end
