# Binks

Ruby command line utilty for managing jar (currently only supports maven) deployments via Gitlab pipelines.

Works by:

* Parse version out of ./pom.xml
* Validate the version
* Apply and push git tag for version (which launches the deploy pipeline)

## Usage

Regular release (from master)
```shell
binks release
```

Force retag
```shell
binks release -f
```

## Dependencies

* [Thor](http://whatisthor.com/)
* [Maven](https://maven.apache.org/)