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
end
