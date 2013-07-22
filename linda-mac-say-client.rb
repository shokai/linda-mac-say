#!/usr/bin/env ruby
require 'rubygems'
require 'em-rocketio-linda-client'
$stdout.sync = true

url =   ENV["LINDA_BASE"]  || ARGV.shift || "http://localhost:5000"
puts space = ENV["LINDA_SPACE"] || "test"
str =   ARGV.shift || "hello"

puts "connecting.. #{url}"
EM::run do
  linda = EM::RocketIO::Linda::Client.new url
  ts = linda.tuplespace[space]

  linda.io.on :connect do  ## RocketIO's "connect" event
    puts "connect!! <#{session}>"
    ts.write ["say", str]
    EM::add_timer 3 do
      exit
    end
  end
end
