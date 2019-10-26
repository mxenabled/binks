require "spec_helper"

describe ::Binks::VersionParser do
  it "parses valid version" do
    expect(described_class.new("0.0.0")).to be_truthy
  end

  it "#to_s" do
    expect(described_class.new("0.0.0").to_s).to eq("0.0.0")
  end
end
