#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra/rocketio/linda/client'
$stdout.sync = true

url =   ENV["LINDA_BASE"]  || ARGV.shift || "http://localhost:5000"
space = ENV["LINDA_SPACE"] || "test"
str =   ARGV.shift || "hello"

puts "connecting.. #{url}"
linda = Sinatra::RocketIO::Linda::Client.new url
ts = linda.tuplespace[space]

linda.io.on :connect do  ## RocketIO's "connect" event
  puts "connect!! <#{session}>"
  ts.write ["say", str]
  exit
end

linda.wait
