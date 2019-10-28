module Binks
  class CommandRunner
    def self.instance(instance = nil)
      @instance = instance unless instance.nil?
      @instance ||= CommandRunner.new
    end

    def self.reset_instance
      @instance = nil
    end

    def self.options
      @options ||= {}
    end

    def self.init(options)
      @options = options
    end

    def run!(cmd)
      if CommandRunner.options[:check_only]
        puts "(check only) #{cmd}" if CommandRunner.options[:verbose]
      else
        puts "#{cmd}" if CommandRunner.options[:verbose]
        `#{cmd}`
      end
    end
  end
end
