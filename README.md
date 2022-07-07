[![pipeline status](https://gitlab.mx.com/mx/binks/badges/master/pipeline.svg)](https://gitlab.mx.com/mx/binks/commits/master) [![coverage report](https://gitlab.mx.com/mx/binks/badges/master/coverage.svg)](https://gitlab.mx.com/mx/binks/commits/master)

# Binks

### Installation

```groovy
plugins {
 id "com.github.mxenabled.binks" version "[VERSION]"
}
```

### Usage

```
./gradlew release
```

Just run validation on current version
```
./gradlew release --check-only
```

#### Arguments

| Arg               | Description                                                     |
|-------------------|-----------------------------------------------------------------|
| check-only        | Skip apply tag and push. Will still do validations              |
| force             | Skip version existence check and force more tag to current hash |
| ignore-dirty-tree | Don't fail if git tree is dirty                                 |
| refresh-tags      | Removes all local tags and fetches tags from origin             |
