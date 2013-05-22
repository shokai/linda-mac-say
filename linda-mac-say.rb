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
    next if tuple.size < 2
    p tuple
    speak = tuple[1].gsub(/[`"'\r\n;]/, '').strip
    system "say #{speak}"
    say.call
  end
}

linda.io.on :connect do
  puts "connect!! <#{session}>"
  say.call
end

loop do
end
