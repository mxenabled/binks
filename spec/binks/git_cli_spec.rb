require "spec_helper"

describe ::Binks::GitCli do
  subject { described_class.new }
  let(:cmd) { double(:command_runner, :run! => nil) }
  before { ::Binks::CommandRunner.instance(cmd) }
  after { ::Binks::CommandRunner.reset_instance }

  describe "#all_tags" do
    before do
      allow(cmd).to receive(:run!).and_return("refs/tag/0.0.0\nrefs/tag/0.0.1")
    end

    it "gets all tags" do
      tags = subject.all_tags
      expect(tags.length).to eq(2)
      expect(tags[0]).to eq("refs/tag/0.0.0")
    end
  end

  describe "#apply_tag" do
    it "invokes command" do
      expect(cmd).to receive(:run!).with("git tag 0.0.1")
      subject.apply_tag("0.0.1", false)
    end

    it "invokes command with force" do
      expect(cmd).to receive(:run!).with("git tag 0.0.1 -f")
      subject.apply_tag("0.0.1", true)
    end
  end

  describe "#current_branch" do
    it "invokes command" do
      expect(cmd).to receive(:run!).with("git rev-parse --abbrev-ref HEAD").and_return("master")
      expect(subject.current_branch).to eq("master")
    end
  end

  describe "#push_tags" do
    it "invokes command" do
      expect(cmd).to receive(:run!).with("git push --tags")
      subject.push_tags(false)
    end

    it "invokes command with force" do
      expect(cmd).to receive(:run!).with("git push --tags -f")
      subject.push_tags(true)
    end
  end
end
