require "spec_helper"

describe ::Binks::VersionParser do
  it "parses valid version" do
    expect(described_class.new("0.0.0")).to be_truthy
  end

  describe "#to_s" do
    it "generates the version without pre" do
      expect(described_class.new("0.0.0").to_s).to eq("0.0.0")
    end

    it "generates the version with pre" do
      expect(described_class.new("0.0.0.pre").to_s).to eq("0.0.0.pre")
    end
  end

  describe ".from_tag" do
    it "extracs the tag portion" do
      expect(described_class.from_tag("1193741908237490182374 refs/tags/0.0.1").to_s).to eq("0.0.1")
    end
  end

  describe ".from_tags" do
    it "extracts all tags" do
      tags = described_class.from_tags([
                                         "1193741908237490182374 refs/tags/0.0.1",
                                         "asdfasdfasgrgg5412425w refs/tags/0.0.2"
                                       ])
      expect(tags.length).to eq(2)
      expect(tags[0].to_s).to eq("0.0.1")
      expect(tags[1].to_s).to eq("0.0.2")
    end
  end
end
