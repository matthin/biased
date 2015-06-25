require "httparty"
require "wikipedia"

module Biased
  # @author Justin Harrison
  class Client
    # The potentially biased website's parent organization.
    attr_reader(:parent)

    # @param [String] domain The potentially biased website's domain.
    def initialize(domain)
      @domain = domain
      @parent = gather_from_wikipedia
    end

    def gather_from_wikipedia
      content = Wikipedia.find(@domain).content
      # Wikipedia has multiple fields for a parent organization,
      # so we need to try each one
      %w(parent owner).each do |field|
        # This Regex should be cleaned up.
        match = /(#{field}\s*=\s\[\[)(.*\w+)/.match(content)
        # Capture group 2 contains only the parent value
        return match[2] if match
      end
    end
  end
end

