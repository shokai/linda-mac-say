#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra/rocketio/linda/client'
$stdout.sync = true

class String
  def sanitize
    self.gsub(/[`"'\r\n;\|><]/, '').strip
  end
end

url =   ENV["LINDA_BASE"]  || ARGV.shift || "http://localhost:5000"
space = ENV["LINDA_SPACE"] || "test"
puts "connecting.. #{url}"
linda = Sinatra::RocketIO::Linda::Client.new url
ts = linda.tuplespace[space]

linda.io.on :connect do  ## RocketIO's "connect" event
  puts "connect!! <#{linda.io.session}> (#{linda.io.type})"
  ts.watch ["say"] do |tuple|
    p tuple
    if tuple.size == 2 or (tuple.size == 3 and tuple[2].kind_of? Hash)
      str = tuple[1].sanitize
      opts = tuple[2] ? tuple[2].map{|k,v| "#{k} #{v}"}.join(' ').sanitize : ""
      system "say #{opts} #{str}"
      ts.write ["say", str, "success"]  # write response
    end
  end

  ts.watch ["saykana"] do |tuple|
    p tuple
    if tuple.size == 2 or (tuple.size == 3 and tuple[2].kind_of? Hash)
      str = tuple[1].sanitize
      opts = tuple[2] ? tuple[2].map{|k,v| "#{k} #{v}"}.join(' ').sanitize : ""
      system "SayKana #{opts} #{str}"
      ts.write ["say", str, "success"]  # write response
    end
  end
end

linda.io.on :disconnect do
  puts "RocketIO disconnected.."
end

linda.wait
