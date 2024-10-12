# lib/points_manager.rb
require 'json'

module PointsManager
  FILE_PATH = "#{Rails.root}/points_data/user_points.json"

  # Load points from a JSON file
  def self.load_points
    if File.exist?(FILE_PATH)
      JSON.parse(File.read(FILE_PATH)).transform_keys(&:to_i)  # Ensure keys are integers (user IDs)
    else
      Hash.new(0)  # Default hash with zero points for new users
    end
  end

  # Save points to a JSON file
  def self.save_points(user_points)
    File.write(FILE_PATH, user_points.to_json)
  end
end
