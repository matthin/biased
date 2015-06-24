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
        parent = /#{field}\s*=\s\[\[([A-Z]).*\w+/.match(content)
                                               .to_s.split("[[")[1]
        return parent if parent
      end
    end
  end
end

