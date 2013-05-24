#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra/rocketio/linda/client'
$stdout.sync = true

url = "http://linda.masuilab.org"
str = ARGV.shift || "hello"

puts "connecting.. #{url}"
linda = Sinatra::RocketIO::Linda::Client.new url
ts = linda.tuplespace["delta"]

linda.io.on :connect do  ## RocketIO's "connect" event
  puts "connect!! <#{session}>"
  ts.write ["say", str]
  exit
end

linda.wait
