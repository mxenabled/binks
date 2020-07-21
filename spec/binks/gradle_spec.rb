require "spec_helper"

describe ::Binks::Gradle do
  let(:build_file) { "spec/resources/build_single_quote.gradle" }

  subject { described_class.new(build_file) }

  context "with single-quotes" do
    let(:build_file) { "spec/resources/build_single_quote.gradle" }

    it "loads version of with correct value" do
      expect("#{subject.version}").to eq("0.0.1")
    end
  end

  context "with double-quotes" do
    let(:build_file) { "spec/resources/build_double_quote.gradle" }

    it "loads version of with correct value" do
      expect("#{subject.version}").to eq("0.0.2")
    end
  end

  it "loads version of type VersionParser" do
    expect(subject.version.class).to eq(::Binks::VersionParser)
  end
end
