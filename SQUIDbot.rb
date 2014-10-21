#!/usr/bin/env ruby
require 'socket'
require 'open-uri'
require 'json'
require './lib/baseball'

class SimpleIrcBot
  def initialize(server, port, channel)
    @channel = channel
    @socket = TCPSocket.open(server, port)
    say "NICK SQUIDbots"
    say "USER ircbot 0 * SQUIDbots"
    say "JOIN ##{@channel}"
    chansay "#{1.chr}ACTION is here to help#{1.chr}"
    chansay "I know the following commands:"
    chansay "!boxscore, !score"
  end

  def say(msg)
    puts msg
    @socket.puts msg
  end

  def chansay(msg)
    say "PRIVMSG ##{@channel} :#{msg}"
  end

  def run
   until @socket.eof? do
      msg = @socket.gets
      puts msg

      if msg.match(/^PING :(.*)$/)
        say "PONG #{$~[1]}"
        next
      end

      if msg.match(/PRIVMSG ##{@channel} :(.*)$/)
        content = $~[1]

        #put matchers here
        if content.match("!score")
	  score
        elsif content.match("!boxscore")
          boxscore
        end
      end
    end
  end

  def quit
    say "PART ##{@channel} :GO GIANTS!"
    say 'QUIT'
  end
end

bot = SimpleIrcBot.new("irc.freenode.com", 6667, 'squidbits')

trap("INT"){ bot.quit }

bot.run
