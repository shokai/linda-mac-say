#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra/rocketio/linda/client'
$stdout.sync = true

url = ARGV.shift || "http://linda.masuilab.org"
puts "connecting.. #{url}"
linda = Sinatra::RocketIO::Linda::Client.new url
ts = linda.tuplespace["delta"]

say = lambda{
  ts.take ["say"] do |tuple|
    p tuple
    if tuple.size == 2
      str = tuple[1].gsub(/[`"'\r\n;]/, '').strip # sanitize
      system "say #{str}"
      ts.write ["say", str, "success"]
    end
    say.call ## recursive call
  end
}

linda.io.on :connect do  ## RocketIO's "connect" event
  puts "connect!! <#{session}>"
  say.call
end

linda.io.on :disconnect do
  puts "disconnected.."
  exit 1
end

loop do
end
