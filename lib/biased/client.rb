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
      @domain = /([a-z]+).(com|net)/.match(article_url)
      gather_from_wikipedia
      @has_bias = Calculator.new(
        HTTParty.get("http://" + article_url).body,
        {parent: @parent}
      ).has_bias
    end

  private
    # Gathers info such as parent organization, staff, and location
    # from wikipedia.
    # @since 0.0.1
    def gather_from_wikipedia
      content = Wikipedia.find(@domain).content
      # Wikipedia has multiple fields for a parent organization,
      # so we need to try each one
      %w(parent owner).each do |field|
        # This Regex should be cleaned up.
        match = /(#{field}\s*=\s\[\[)(.*\w+)/.match(content)
        if match
          @parent = match[2]
          break
        end
      end

      parse_staff(content)
    end

    def parse_staff(content)
      if match = /(key_people\s+=\s.*\])/.match(content)
        line = match[1]
      else
        return
      end

      @staff = []
      index = 0

      if matches = line.scan(/(?:[^(]\[\[)(\w+ \w+)(?:\]\])/)
        matches.each {|match| @staff << match }
      end
    end
  end
end

