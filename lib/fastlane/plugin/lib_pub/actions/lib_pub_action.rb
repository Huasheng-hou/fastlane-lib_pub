require 'fastlane/action'
require_relative '../helper/lib_pub_helper'

module Fastlane
  module Actions
    class LibPubAction < Action
      def self.run(params)

        UI.message "Parameter Version: #{params[:version]}"

        version = params[:version]
        spec_path = ENV["SPEC_PATH"];

        if other_action.git_tag_exists(tag: version)
          UI.message "tag #{version} exists!, Please remove it or use another version number."
        else
          other_action.add_git_tag(tag: version)
          other_action.push_git_tags(tag: version)

          other_action.version_bump_podspec(path: spec_path, version_number: version)

          other_action.pod_push(path: spec_path, 
            repo: ENV["REPO"],
            sources: params[:sources],
            allow_warnings: params[:allow_warnings],
            use_libraries: params[:use_libraries],
            verbose: true)

          other_action.git_add(path: ".")
          other_action.git_commit(path: ["."], message: "Update podspec")
          other_action.push_to_git_remote
        end
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
          FastlaneCore::ConfigItem.new(key: :version,
                                  env_name: "LIB_PUB_YOUR_OPTION",
                               description: "The pod version",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :allow_warnings,
                                  env_name: "LIB_PUB_YOUR_OPTION",
                               description: "Allow the pod to have warnings",
                                  optional: true,
                             default_value: false,
                                 is_string: false),
          FastlaneCore::ConfigItem.new(key: :use_libraries,
                                  env_name: "LIB_PUB_YOUR_OPTION",
                               description: "Allow the to use libraries",
                                  optional: true,
                             default_value: false,
                                 is_string: false),
          FastlaneCore::ConfigItem.new(key: :sources,
                                  env_name: "LIB_PUB_YOUR_OPTION",
                               description: "The pod sources",
                                  optional: true,
                                      type: Array)
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
