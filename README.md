[![](https://jitpack.io/v/mxenabled/binks.svg)](https://jitpack.io/#mxenabled/binks)

# Binks

Binks is a simple plugin that validates and creates release tags to launch jar project release pipelines. 

### Installation

Binks is hosted via [JitPack](https://jitpack.io/p/mxenabled/binks).

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
