require "biased/calculator"

require "httparty"
require "wikipedia"

module Biased
  # The main class that a end user will use to interact with the application.
  # @author Justin Harrison
  # @since 0.0.1
  # @attr_reader [String] parent The potentially biased website's parent
  #                              organization.
  # attr_reader [Boolean] has_bias Whether or not the article is biased.
  #   Biased::Client.new(
  #     "http://www.huffingtonpost.com/"\
  #     "2015/05/12/verizon-aol-huffpost_n_7269056.html"
  #   )
  class Client
    attr_reader(:parent, :has_bias)

    # @param [String] article_url The potentially biased article's URL.
    def initialize(article_url)
      # Add more TLDs than just com, and net.
      @domain = /.*([^\.]+)(com|net)/.match(article_url)
      @parent = gather_from_wikipedia
      @has_bias = Calculator.new(
        HTTParty.get("http://" + article_url).body,
        {parent: @parent}
      ).has_bias
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

