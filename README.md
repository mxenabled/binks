# Binks

Ruby command line utilty for managing jar (currently only supports maven) deployments via Gitlab pipelines.

## Usage

Regular release (from master)
```shell
$ binks release
```

Force retag
```shell
$ binks release -f
```

## Dependencies

* [Thor](http://whatisthor.com/)