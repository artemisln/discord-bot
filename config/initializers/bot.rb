require 'discordrb'

ChannelID = 1294542561469530143



Dir["#{Rails.root}/app/commands/*.rb"].each { |file| require file }
Bot.run(true)

puts "Invite URL: #{Bot.invite_url}"