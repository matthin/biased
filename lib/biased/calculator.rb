require "oga"

module Biased
  # Calculates whether or not a given article is biased.
  # #attr_reader [Boolean] has_bias Whether or not the article is biased.
  class Calculator
    attr_reader(:has_bias)

    # @param [String] article The article which is checked for bias.
    # @param [Hash] info Additional info such as parent, nation, and CEO.
    def initialize(article, info)
      @article = article
      title = Oga.parse_html(article).at_css("h1")
      if title
        if title.text =~ Regexp.new(info[:parent], "i")
          @has_bias = true
        end

        info[:staff] ||= []
        info[:staff].each do |member|
          if title.text =~ Regexp.new(member, "i")
            @has_bias = true
          end
        end
      end

      @has_bias ||= false
    end
  end
end

