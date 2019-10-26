require "optparse"

desc "Parses pom for version, tags w/ version and pushes"
task :release do
  options = {}
  opt_parser = ::OptionParser.new do |opts|
    opts.banner = "Usage: rake release -- [options]"
    opts.on("-f", "--force", "Force move version tag") do
      options[:force] = true
    end
    opts.on("-c", "--check", "Check version only. Don't tag.") do
      options[:check] = true
    end
    opts.on("-v", "--verbose", "Show all git commands") do
      options[:check] = true
    end
    opts.on("-h", "--help", "Pring this help") do
      puts opts
      exit 1
    end
  end

  opt_parser.order!(ARGV) {}
  opt_parser.parse!(options) {}

  ::Binks::CommandRunner.init(options)

  jar = ::Binks::Jar.new(options)

  begin
    jar.validate!
  rescue ::Binks::BinksError => e
    puts "ERROR: #{e.message}"
    puts ""
    puts opt_parser
    puts ""
    puts "Version rules:"
    puts "  * Format: ###.###.###[.pre] (each segment must be 1 to 3 digits)"
    puts "  * .pre versions only allowed on a branch"
    puts "  * Cannot reuse the same tag (unless using the --force flag)"
    exit 1
  end

  jar.publish!
end
