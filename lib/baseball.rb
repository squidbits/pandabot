#!/usr/bin/env ruby

require 'json'
require 'open-uri'


FEED_URL  = "http://gd2.mlb.com/components/game/mlb/year_#{Time.now.year}/month_#{Time.now.month}/day_16/master_scoreboard.json"
SCHED_URL = "http://sanfrancisco.giants.mlb.com/gen/schedule/sf/#{Time.now.year}_#{Time.now.month}.json"

def score
  feed_data = JSON.parse( open( FEED_URL ).read )
  begin
    home_name   = feed_data["data"]["games"]["game"]["home_team_name"]
    away_name   = feed_data["data"]["games"]["game"]["away_team_name"]
    home_score  = feed_data["data"]["games"]["game"]["linescore"]["r"]["home"]
    away_score  = feed_data["data"]["games"]["game"]["linescore"]["r"]["away"]
    chansay away_name + " | " + away_score + " || " +  home_name + " | " +  home_score 
  rescue
    say "There's no game, or something went wrong."
    return
  end

end

def boxscore
  feed_data = JSON.parse( open( FEED_URL ).read )
  begin
    away_name   = feed_data["data"]["games"]["game"]["away_team_name"]
    home_name   = feed_data["data"]["games"]["game"]["home_team_name"]
    t1          = feed_data["data"]["games"]["game"]["linescore"]["inning"][0]["away"] || " "
    b1          = feed_data["data"]["games"]["game"]["linescore"]["inning"][0]["home"] || " "
    t2          = feed_data["data"]["games"]["game"]["linescore"]["inning"][1]["away"] || " "
    b2          = feed_data["data"]["games"]["game"]["linescore"]["inning"][1]["home"] || " "
    t3          = feed_data["data"]["games"]["game"]["linescore"]["inning"][2]["away"] || " "
    b3          = feed_data["data"]["games"]["game"]["linescore"]["inning"][2]["home"] || " "
    t4          = feed_data["data"]["games"]["game"]["linescore"]["inning"][3]["away"] || " "
    b4          = feed_data["data"]["games"]["game"]["linescore"]["inning"][3]["home"] || " "
    t5          = feed_data["data"]["games"]["game"]["linescore"]["inning"][4]["away"] || " "
    b5          = feed_data["data"]["games"]["game"]["linescore"]["inning"][4]["home"] || " "
    t6          = feed_data["data"]["games"]["game"]["linescore"]["inning"][5]["away"] || " "
    b6          = feed_data["data"]["games"]["game"]["linescore"]["inning"][5]["home"] || " "
    t7          = feed_data["data"]["games"]["game"]["linescore"]["inning"][6]["away"] || " "
    b7          = feed_data["data"]["games"]["game"]["linescore"]["inning"][6]["home"] || " "
    t8          = feed_data["data"]["games"]["game"]["linescore"]["inning"][7]["away"] || " "
    b8          = feed_data["data"]["games"]["game"]["linescore"]["inning"][7]["home"] || " "
    t9          = feed_data["data"]["games"]["game"]["linescore"]["inning"][8]["away"] || " "
    b9          = feed_data["data"]["games"]["game"]["linescore"]["inning"][8]["home"] || " "
    tt          = feed_data["data"]["games"]["game"]["linescore"]["r"]["away"]
    bt          = feed_data["data"]["games"]["game"]["linescore"]["r"]["home"]

    size = away_name.length
    size = home_size unless away_name.length > home_name.length

    chansay( pad( " ", size + 4 ) + "1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 || F" )
    chansay( pad( away_name, size ) + " => " + t1 + " | " + t2 + " | " + t3 + " | " + t4 + " | " + t5 + " | " + t6 + " | " + t7 + " | " + t8 + " | " + t9 + " || " + tt )
    chansay( pad( home_name, size ) + " => " + b1 + " | " + b2 + " | " + b3 + " | " + b4 + " | " + b5 + " | " + b6 + " | " + b7 + " | " + b8 + " | " + b9 + " || " + bt )
  rescue
    chansay "There's no game, or something went wrong."
    return
  end
end

def headlines
end

def settopic
end

def batter
end

def pitcher
end

def exit
end

def pad( text, size )
  return text.center( size )
end

#require 'pry'; binding.pry
