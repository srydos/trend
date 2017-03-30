#!/usr/bin/env ruby
require 'date' 
WORK_DIR=File.expand_path(__FILE__).sub(/[^\/]+$/,'')
require WORK_DIR + 'TetesolTwitter.rb'
twitter_user = TetesolTwitter.new
#ツイート時刻取得
def tweet_id2time(id)
  case id
  when Integer
    Time.at(((id >> 22) + 1288834974657) / 1000.0)
  else
    nil
  end
end
#YAMLにして同ディレクトリに排出
def export_yaml( trends_hash )
  open("./data_trend.yml","a+") do |e|
    YAML.dump(trends_hash,e)
  end
end
#トレンドを表示 日本2345896 
trends_local_plane = twitter_user.local_trends( 23424856 )
trends_hash = {}
trend_data  = []
trends_hash["Time"] = Time.now
#hash in array in jsonの入れ子になっている
trends_local_plane.to_hash[:trends].each do | hash |
  #:urlは:queryと実質中身が同じなので取り除く
  hash.delete(:url)
  trend_data << hash
end
trends_hash["data"] = trend_data
export_yaml( trends_hash )
