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
end

