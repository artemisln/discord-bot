require 'json'
require 'fileutils'

module PointsManager
  # Set the file path for saving points
  FILE_PATH = "#{Dir.pwd}/points_data/user_points.json"

  # Ensure the directory exists
  FileUtils.mkdir_p(File.dirname(FILE_PATH))

  # Load points from a JSON file
  def self.load_points
    puts "Loading points from #{FILE_PATH}"  # Debug output
    return {} unless File.exist?(FILE_PATH)

    # Read and parse the JSON file
    data = JSON.parse(File.read(FILE_PATH))

    # Create a new hash with transformed keys ensuring they are integers
    data.each_with_object({}) do |(server_id, server_data), result|
      next unless server_data.is_a?(Hash)  # Ensure server_data is a Hash
      result[server_id.to_i] = server_data.each_with_object({}) do |(user_id, points), user_result|
        user_result[user_id.to_i] = points if points.is_a?(Numeric)  # Ensure points is a Numeric value
      end
    end
  rescue JSON::ParserError => e
    puts "Error loading points: #{e.message}"  # Log any parsing errors
    {}
  end

  # Save points to a JSON file
  def self.save_points(user_points)
    puts "Saving points to #{FILE_PATH}"  # Debug output
    File.write(FILE_PATH, JSON.pretty_generate(user_points))
  end

  # Reset points data (optional)
  def self.reset_points
    File.write(FILE_PATH, JSON.pretty_generate({}))
  end
end
