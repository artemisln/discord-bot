module Ping
    extend Discordrb::Commands::CommandContainer
    require_relative '../../lib/points_manager'
    # Chat

    # Give out information about the server
    Bot.message do |event|
        if event.message.content.downcase.include?("information")
          event.respond "Did you ask for information? Well, the server you're in was made in 12 October 2024 by Artemis. Hope that helped :)"
        end
      end

    # Say hello to the people 
    greetings = ["hi", "hey", "hello", "geia"]

    Bot.message do |event|
        if greetings.any? { |greeting| event.message.content.downcase.include?(greeting) }
            event.respond "Hey to you too! :)"
        end
    end


    # Commands

    Bot.command(:info) do |event|
        event.respond "Did you ask for information? Well, the server you're in was made in 12 October 2024 by . Hope that helped :)"
    end

    Bot.command(:help) do |event|
        event.respond "For info press /info. Owner's username for any problems is:"
    end

    # Points

    # Initialize a hash to store points for each user
    user_points = PointsManager.load_points

    CHANNEL_PONTON = 1294577580527321141
    Bot.message do |event|
        user_id = event.user.id
        user_points[user_id] ||= 0
        user_points[user_id] += 1
        PointsManager.save_points(user_points)
        message = "Congratulations #{event.user.name}, you sent a message and you now have #{user_points[user_id]} points!"

        target_channel = event.bot.channel(CHANNEL_PONTON)
        target_channel.send_message(message) if target_channel
    end

    Bot.message do |event|
        user_id = event.user.id  # Get the user ID
        user_points[user_id] ||= 0  # Initialize points for new users if they don't exist
      
        if event.message.content.downcase.include?("points")
          event.respond "These are your points! You have #{user_points[user_id]} points."
        end
      end

      Bot.command(:leaderboard) do |event|
        # Sort users by points in descending order and take the top 5
        sorted_users = user_points.sort_by { |user_id, points| -points }.first(5)
      
        # Create a leaderboard message
        leaderboard_message = "Top 5 Users by Points:\n"
        sorted_users.each do |user_id, points|
          user = event.bot.user(user_id)  # Fetch user object
          leaderboard_message += "#{user.name}: #{points} points\n"
        end
      
        # Respond with the leaderboard
        event.respond(leaderboard_message)
      end
      
    

end