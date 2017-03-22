#!/usr/bin/env ruby
WORK_DIR=Dir.getwd
require 'twitter'
require 'pp'
require 'yaml'
require 'date' #そのうちいらなくなる
#ツイート時刻取得
def tweet_id2time(id)
  case id
  when Integer
    Time.at(((id >> 22) + 1288834974657) / 1000.0)
  else
    nil
  end
end
#ツイートアカウント取得
key = YAML.load_file(WORK_DIR + "/user.yml")
client = Twitter::REST::Client.new(
  consumer_key:        key["consumer_key"],
  consumer_secret:     key["consumer_secret"],
  access_token:        key["access_token"],
  access_token_secret: key["access_token_secret"]
)
#トレンドを表示 日本2345896 
trends_local_plane = client.local_trends(23424856)
trends_hash = {}
trend_data  = []
trends_hash["Time"] = Time.now
#hash in array in jsonの入れ子になっている
trends_local_plane.to_hash[:trends].each do | hash |
  #:urlは:queryと中身が同じなので取り除く
  hash.delete(:url)
  trend_data << hash
end
trends_hash["data"] = trend_data
#  p rec.delete_if{ | key, value | key == :url};}
#trends_hash["data"] = trends_local_plane.map{ |rec| rec.to_hash }
#trends_hash.map{|item| p item }
open("./data_trend.yml","a+") do |e|
  YAML.dump(trends_hash,e)
end
