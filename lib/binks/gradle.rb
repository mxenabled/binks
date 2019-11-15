module Binks
  class Gradle
    GRADLE_VERSION = %r{version[\s]*\=[\s]*'(?<version>[\.\d]+(|\.pre))'}

    attr_reader :filename

    def initialize(filename)
      @filename = filename
      @text = ::File.read(@filename)
    end

    def version
      @version ||= begin
        match = @text.match(GRADLE_VERSION)
        ::Binks::VersionParser.new(match[:version])
      end
    end
  end
end
