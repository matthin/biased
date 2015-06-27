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
        {parent: @parent, staff: @staff}
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
        parent = parse_field(content, field)
        if parent.length > 0
          @parent = parent[0]
        end
      end

      @staff = parse_field(content, "key_people")
    end

    # Parses a specific wikipedia field and returns the results.
    # @param [String] content The content of a wikipedia article.
    # @param [String] field The field where the results will be found.
    # @return [Array] The results found inside the specified field.
    def parse_field(content, field)
      if match = /(#{field}\s+=\s.*\])/.match(content)
        line = match[1]
      else
        return []
      end

      results = []
      if matches = line.scan(/(?:\[\[)([\w\s]+)(?:\]\])/)
        # scan returns all matches as an array of chars
        matches.each {|match| results << match.join("")}
      end
      results
    end
  end
end

