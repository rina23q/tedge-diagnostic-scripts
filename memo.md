# Memo

## Design 2
Changes from the Design 1:
* the output of each plugin is collected under a subdirectory
* stderr of plguin execution itself also has to be captured
* the output directory by default is `/tmp`
* the output directory and the tarball name must be configured by CLI options

### Next steps
* Write a doc about the contract between runner and plugins

## Fidings fron the Design 1
### Output file scope: merged vs separated per scope
I think the latter is better because it will be easier to reformat.
For example, entity store collection uses `tedge http get` and it returns JSON but not  beautified.
```
$ tedge http get /tedge/v1/entities
[{"@topic-id":"device/main//","@type":"device"},{"@topic-id":"device/main/service/c8y-firmware-plugin","@parent":"device/main//","@type":"service"},{"@topic-id":"device/main/service/tedge-agent","@parent":"device/main//","@type":"service"},{"@topic-id":"device/main/service/tedge-mapper-c8y","@parent":"device/main//","@type":"service"},{"@topic-id":"device/main/service/mosquitto-c8y-bridge","@parent":"device/main//","@type":"service"}]
```

Better not add `jq` as it adds extra dependency.

### Permissions
- Can't read `/var/log/mosquitto/mosquitto.log` (`400` by `mosquitto` user) without `sudo`
