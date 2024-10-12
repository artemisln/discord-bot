require 'discordrb'

ChannelID = 1294542561469530143

Bot = Discordrb::Commands::CommandBot.new(
    token: 'MTI5NDU2NDQ1NTEyODIzNjA2Mw.GpTsXF.J27-aFCnsbzQkpXiH2vL8WIBBwdFpooTtCGwiU',
    client_id: '1294564455128236063',
    prefix: "$"
)

Dir["#{Rails.root}/app/commands/*.rb"].each { |file| require file }
Bot.run(true)

puts "Invite URL: #{Bot.invite_url}"