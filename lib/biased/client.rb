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
      /parent\s*=\s\[\[([A-Z])\w+/.match(content).to_s.split("[[")[1]
    end
  end
end

