require "spec_helper"
require "biased/calculator"

describe(Biased::Calculator) do
  context("with a biased article") do
    it("detects bias") do
      @calculator = Biased::Calculator.new(
        "<h1>AOL CEO On Verizon Deal: HuffPost"\
        "'Will Always Be A Cornerstone Of AOL'</h1>",
        {parent: "AOL"}
      )
      expect(@calculator.has_bias).to(eq(true))
    end
  end
end

