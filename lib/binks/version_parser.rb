module Binks
  class VersionParser
    VERSION = /^(?<major>[\d]{1,3})\.(?<minor>[\d]{1,3})\.(?<patch>[\d]{1,3})(?<pre>$|\.pre$)/.freeze
    VERSION_FROM_TAG = %r{refs\/tags\/(?<version>.+)$}.freeze

    def self.from_tag(tag)
      match = tag.match(VERSION_FROM_TAG)
      version = match.nil? ? "" : match[:version]
      if version.empty?
        nil
      else
        VersionParser.new(version)
      end
    end

    def self.from_tags(tags)
      tags.reject(&:empty?).map(&:strip).map { |tag| from_tag(tag) }.reject(&:nil?)
    end

    attr_reader :version, :pre

    def initialize(version)
      @version = version

      match = version.match(VERSION)
      unless match.nil?
        @pre = match[:pre]
      end
    end

    def pre?
      !pre.empty?
    end

    def valid?
      VERSION =~ version
    end

    def to_s
      version
    end

    def ==(other)
      other.class == self.class && other.to_s == self.to_s
    end
  end
end
