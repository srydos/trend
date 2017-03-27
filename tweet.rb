#!/usr/bin/env ruby
WORK_DIR=File.expand_path(__FILE__).sub(/[^\/]+$/,'')
require 'twitter'
require 'pp'
require 'yaml'
key = YAML.load_file(WORK_DIR + "/user.yml")
client = Twitter::REST::Client.new(
  consumer_key:        key["consumer_key"],
  consumer_secret:     key["consumer_secret"],
  access_token:        key["access_token"],
  access_token_secret: key["access_token_secret"]
)
msg = ''
if ARGV[0] == nil or ARGV[0] == '' then
  print "input massage! : "
  msg=STDIN.gets
else
  #半角スペース対応
  ARGV.each do | text |
    msg += text + ' '
  end
  msg[/ $/]= ''
end
puts msg
client.update(msg)
