#!/usr/bin/env ruby


require 'webrick'
require 'socket'
require 'openssl'
require 'net/http'
require 'rexml/document'
require 'json'


#puts "argv : #{ARGV}"
def localip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily
    UDPSocket.open do |s|
        s.connect '174.142.8.58', 1
        s.addr.last
    end
    ensure
    Socket.do_not_reverse_lookup = orig
end

def public_ipv4
  Socket.ip_address_list.select{|intf| intf.ipv4? and !intf.ipv4_loopback? and !intf.ipv4_multicast?}.map{|ipv| ipv.ip_address}.uniq
end


host = ARGV && ARGV[0] ? ARGV[0] : localip
hosts = public_ipv4.push(host).uniq
port = 8081
securePort = 8082
securePortWithClientAuth = 8083
webSocketPort = 8084

$local_server = WEBrick::HTTPServer.new :Port => port, :DocumentRoot => "Documents"

t1 = Thread.new do
    puts "Starting local server on #{host}:#{port}"
    $local_server.start
end

trap 'INT' do
    puts "Shutting down http server"
    $local_server.shutdown
    puts "shutdown finished"
end

t1.join
