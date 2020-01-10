require 'fastlane/action'
require_relative '../helper/lib_pub_helper'

module Fastlane
  module Actions
    class LibPubAction < Action
      def self.run(params)
        UI.message("The lib_pub plugin is working!")
      end

      def self.description
        "pod lib publish"
      end

      def self.authors
        ["Huasheng Hou"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "发布私有pod库"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "LIB_PUB_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
