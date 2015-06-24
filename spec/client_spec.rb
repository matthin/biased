require "spec_helper"
require "biased/client"

describe(Biased::Client) do
  before do
    allow(Wikipedia).to(
      receive_message_chain(:find, :content).and_return("owner = [[AOL]]")
    )
    @client = Biased::Client.new("huffingtonpost.com")
  end

  it("creates a parent") do
    expect(@client.parent).to(eq("AOL"))
  end
end

