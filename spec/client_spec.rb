require "spec_helper"
require "biased/client"

describe(Biased::Client) do
  context("creates a parent") do
    it("with one word") do
      allow(Wikipedia).to(
        receive_message_chain(:find, :content).and_return("owner = [[AOL]]")
      )
      @client = Biased::Client.new("huffingtonpost.com")
      expect(@client.parent).to(eq("AOL"))
    end

    it("with two words") do
      allow(Wikipedia).to(
        receive_message_chain(:find, :content).and_return("owner = [[Vox Media]]")
      )
      @client = Biased::Client.new("theverge.com")
      expect(@client.parent).to(eq("Vox Media"))
    end
  end

  context("with a biased article") do
    it("detects bias") do
      allow(Wikipedia).to(
        receive_message_chain(:find, :content).and_return("owner = [[AOL]]")
      )
      allow(HTTParty).to(
        receive_message_chain(:get, :body).and_return(
          "<h1>AOL CEO On Verizon Deal: HuffPost"\
          "'Will Always Be A Cornerstone Of AOL'</h1>"
        )
      )
      @client = Biased::Client.new(
        "huffingtonpost.com/2015/05/12/verizon-aol-huffpost_n_7269056.html"
      )
      expect(@client.has_bias).to(eq(true))
    end
  end
end

