# frozen_string_literal: true

unless defined?(Screen::Base)
  require "bundler"
  Bundler.setup(:default)

  $LOAD_PATH.find { |path| path.include?("screen-base") }.tap do |path|
    require "#{path}/screen/base"
  end
end

module Screen
  class GuessCharacter < Screen::Base
    def payload_schema
      {
        "type" => "object",
        "required" => ["characters", "color"],
        "properties" => {
          "characters" => {
            "type" => "array",
            "items" => {
              "type" => "object",
              "required" => ["value", "position"],
              "properties" => {
                "value" => {
                  "type" => "string"
                },
                "position" => {
                  "type" => "string"
                }
              }
            }
          },
          "color" => {
            "type" => "string"
          }
        }
      }
    end

    def preprocess_payload
      payload["characters"].each do |character|
        character["value"] = character["value"].to_s
        character["position"] = character["position"].to_s.to_i
      end
      payload
    end

    def answer_errors
      return ["can't be blank"] if answer.blank?
      return ["can't be longer than 1 character"] if answer.length > 1
      []
    end
  end
end
