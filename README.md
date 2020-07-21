[![pipeline status](https://gitlab.mx.com/mx/binks/badges/master/pipeline.svg)](https://gitlab.mx.com/mx/binks/commits/master) [![coverage report](https://gitlab.mx.com/mx/binks/badges/master/coverage.svg)](https://gitlab.mx.com/mx/binks/commits/master)

# Binks

Ruby command line utilty for managing jar (currently only supports maven) deployments via Gitlab pipelines.

Works by doing the following:

* Parse version out of ./pom.xml
* Validate the version
* Apply and push git tag for version (which launches the deploy pipeline)

### Installation

Binks can be used in two ways -- as a standalone binary or rake task add-in

#### Add Raketasks

Add the following to Gemfile:

```ruby
source "https://gems.internal.mx" do
  gem "binks"
end
```

Add the following to Rakefile

```ruby
require "binks/rake_task"
```

### Usage

#### As a rake task

Regular release (from master)
```shell
rake release
```

Force retag
```shell
rake release -- -f
```

#### As a binary

Regular release (from master)
```shell
binks release
```

Force retag
```shell
binks release -f
```

### Contributing

See [process wiki page](https://gitlab.mx.com/mx/io/wikis/Gems) for details on updating a gem.

1. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Versioning

Clone the repo and create a topic branch. Generate a merge request. Once approved, merge to master. In master bump the gem version. To maintain some semblance of sanity, slight modifications should result in point bump (e.g. 0.1.0 to 0.1.1) and more significant changes like new messages or endpoints should result in a minor bump (e.g. 0.1.1 to 0.2.0).

**Please commit your version bump separately from your other changes.** It makes it much easier to track down when versions changed and what changes are in each version.

After committing and pushing the version change, run:

```shell
rake release
```

to push the gem to `gems.internal.mx`

## Dependencies

* [Thor](http://whatisthor.com/)
* [Maven](https://maven.apache.org/)

## Future Enhancements

Look implementing something like [thor-scmversion](https://github.com/RiotGamesMinions/thor-scmversion) with version bump actions
