require "spec_helper"

describe ::Binks::Gradle do
  subject { described_class.new("build.gradle") }

  it "loads version of with correct value" do
    expect("#{subject.version}").to eq("0.0.1")
  end

  it "loads version of type VersionParser" do
    expect(subject.version.class).to eq(::Binks::VersionParser)
  end
end
