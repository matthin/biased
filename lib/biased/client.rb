require "httparty"
require "wikipedia"

module Biased
  # The main class that a end user will use to interact with the application.
  # @author Justin Harrison
  # @since 0.0.1
  # @attr_reader [String] parent The potentially biased website's parent
  #                              organization.
  #   Biased::Client.new("huffingtonpost.com")
  class Client
    attr_reader(:parent)

    # @param [String] domain The potentially biased website's domain.
    def initialize(domain)
      @domain = domain
      @parent = gather_from_wikipedia
    end

    # Gathers the parent organization of any website from wikipedia
    # if possible.
    # @since 0.0.1
    # @return [String, nil] The parent organization or nil.
    def gather_from_wikipedia
      parent = nil
      content = Wikipedia.find(@domain).content
      # Wikipedia has multiple fields for a parent organization,
      # so we need to try each one
      %w(parent owner).each do |field|
        # This Regex should be cleaned up.
        match = /(#{field}\s*=\s\[\[)(.*\w+)/.match(content)
        if match
          parent = match[2]
          break
        end
      end

      parent
    end
  end
end

