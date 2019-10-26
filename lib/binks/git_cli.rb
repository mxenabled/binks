# frozen_string_literal: true

module Binks
  class GitCli
    def all_tags
      run!("git fetch --tags --force")
      run!("git for-each-ref refs/tags").split("\n")
    end

    def apply_tag(tag, force)
      run!("git tag #{tag}#{force ? ' -f' : ''}")
    end

    def current_branch
      run!("git rev-parse --abbrev-ref HEAD").strip
    end

    def push_tags(force)
      run!("git push --tags origin #{version}#{force ? ' -f' : ''}")
    end

  private

    def run!(cmd)
      ::Binks::CommandRunner.instance.run!(cmd)
    end
  end
end
