# frozen_string_literal: true

module Binks
  class Jar
    attr_accessor :force

    def initialize(options)
      @force = options[:force]
    end

    def branch
      @branch ||= git.current_branch
    end

    def publish!
      git.apply_tag(version, force)
      git.push_tags(force)
    end

    def validate!
      raise ::Binks::BinksError, "Invalid version \"#{version}\"" unless version.valid?
      raise ::Binks::BinksError, "Dirty tree. Commit your changes" if !force && git.dirty?
      raise ::Binks::BinksError, "Pre release versions must be released from a topic branch (not master)" if branch == "master" && version.pre?
      raise ::Binks::BinksError, "Version already used" if !force && versions.any? { |v| v.to_s == version.to_s }
    end

    def version
      @version ||= pom.version
    end

    def versions
      @versions ||= ::Binks::VersionParser.from_tags(git.all_tags)
    end

  private

    def git
      @git ||= ::Binks::GitCli.new
    end

    def pom
      @pom ||= ::Binks::Pom.new("pom.xml")
    end
  end
end
