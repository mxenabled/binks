require "nokogiri"

module Binks
  class Pom
    attr_reader :filename

    def initialize(filename)
      @filename = filename
      @pom = Nokogiri::XML(File.open("pom.xml"))
    end

    def version
      @version ||= ::Binks::VersionParser.new(@pom.search("version")[0].text.strip)
    end
  end
end
