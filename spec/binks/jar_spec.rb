require "spec_helper"

describe ::Binks::Jar do
  let(:version) { "0.0.1" }
  let(:branch) { "master" }
  let(:all_tags) { [] }
  let(:dirty) { false }
  let(:build) { double(:build, :version => ::Binks::VersionParser.new(version)) }
  let(:git) { double(:git) }

  let(:options) { {} }
  subject { described_class.new(options) }

  before do
    allow(::Binks::GitCli).to receive(:new).and_return(git)
    allow(::Binks::Gradle).to receive(:new).and_return(build)

    allow(git).to receive(:current_branch).and_return(branch)
    allow(git).to receive(:all_tags).and_return(all_tags)
    allow(git).to receive(:dirty?).and_return(dirty)
  end

  describe "#branch" do
    before { allow(git).to receive(:current_branch).and_return("master") }

    it "returns current branch" do
      expect(subject.branch).to eq("master")
    end
  end

  describe "#publish!" do
    let(:version_st) { "0.0.1" }

    it "applies the version tag" do
      expect(git).to receive(:apply_tag)
      expect(git).to receive(:push_tags)

      subject.publish!
    end
  end

  describe "validate!" do
    context "with dirty tree" do
      let(:dirty) { true }

      it "is invalid" do
        expect do
          subject.validate!
        end.to raise_error(::Binks::BinksError, "Dirty tree. Commit your changes")
      end
    end

    context "non pre version" do
      let(:version) { "0.0.1" }

      context "on master" do
        let(:branch) { "master" }
        let(:all_tags) { ["97987978987 refs/tags/0.0.0"] }

        it "is valid" do
          subject.validate!
        end

        context "duplicate tag" do
          let(:version) { "0.0.1" }
          let(:all_tags) { ["97987978987 refs/tags/0.0.1"] }

          it "is invalid" do
            expect do
              subject.validate!
            end.to raise_error(::Binks::BinksError, "Version (0.0.1) already used")
          end
        end
      end
    end

    context "pre version" do
      let(:version) { "0.0.1.pre" }

      context "on master" do
        let(:branch) { "master" }
        let(:all_tags) { ["97987978987 refs/tags/0.0.0"] }

        it "is invalid" do
          expect do
            subject.validate!
          end.to raise_error(::Binks::BinksError, "Pre release versions must be released from a topic branch (not master)")
        end
      end
    end
  end

  describe "#version" do
    let(:version) { "0.0.2" }

    it "gives version from build" do
      expect(subject.version.to_s).to eq(version)
    end
  end

  describe "#versions" do
    context "with valid tags" do
      before do
        allow(git).to receive(:all_tags).and_return([
                                                      "12341234134 refs/tags/0.0.1",
                                                      "12341234134 refs/tags/0.0.2",
                                                    ])
      end

      it "builds versions" do
        tags = subject.versions
        expect(tags.length).to eq(2)
      end
    end

    context "with invalid tags" do
      before do
        allow(git).to receive(:all_tags).and_return([
                                                      "12341234134 refs/tags/0.0.1",
                                                      "12341234134 refs/tags/0.0.2",
                                                      "12341234134 refs/tags/0.0.3ADF",
                                                    ])
      end

      it "builds all versions, even invalid" do
        tags = subject.versions

        expect(tags.length).to eq(3)
        expect(tags[0].valid?).to eq(true)
        expect(tags[1].valid?).to eq(true)
        expect(tags[2].valid?).to eq(false)
      end
    end
  end
end
