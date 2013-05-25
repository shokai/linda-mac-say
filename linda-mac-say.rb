#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra/rocketio/linda/client'
$stdout.sync = true

url =   ENV["LINDA_BASE"]  || ARGV.shift || "http://localhost:5000"
space = ENV["LINDA_SPACE"] || "test"
puts "connecting.. #{url}"
linda = Sinatra::RocketIO::Linda::Client.new url
ts = linda.tuplespace[space]

linda.io.on :connect do  ## RocketIO's "connect" event
  puts "connect!! <#{linda.io.session}> (#{linda.io.type})"
  ts.watch ["say"] do |tuple|
    p tuple
    if tuple.size == 2
      str = tuple[1].gsub(/[`"'\r\n;]/, '').strip # sanitize input data
      system "say #{str}"
      ts.write ["say", str, "success"]  # write response
    end
  end
end

linda.io.on :disconnect do
  puts "RocketIO disconnected.."
end

linda.wait
