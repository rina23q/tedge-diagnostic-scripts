# Contract between runner and plugins

## Runner's responsibility
* Runner creates an output directory `<PLUGIN_DIR>/<TARBALL_NAME>` and subdirectories for each plugin `<PLUGIN_DIR>/<TARBALL_NAME>/<PLUGIN_NAME>`.
* Runner doesn't know about each plugin script. Runner executes all the plugin scripts under `<PLUGIN_DIR>` blindly with arguments.
    * arg1: `collect`
    * arg2: the path to the subdirectory, `<PLUGIN_DIR>/<TARBALL_NAME>/<PLUGIN_NAME>`
* Runner logs stdout and stderr from the each plugin's execution and store them as `<PLUGIN_NAME>.out`(stdout) and `<PLUGIN_NAME>.err`(stderr).
* Runner makes a tarball for the output directory `<PLUGIN_DIR>/<TARBALL_NAME>` as `<TARBALL_NAME>.tar.gz`.
* Runner takes care of the exit codes of plugins. Runner's exit code is `0` if either `0` or `2` returns from each plugin. Otherwise `1`.
    * 0: plugin execution successful
    * 1: some error occurs while executing the plugin
    * 2: skipped / not applicable (e.g. mosquitto plugin is not applicable when built-in bridge is used)


### Usage
```shell
$ tedge diag collect [OPTIONS]
```

#### Options
* `--plugin-dir <PLUGIN_DIR>`: Directory where plugins are stored (default: `/etc/tedge/diag-plugins`)
* `--output-dir <OUTPUT_DIR>`: Directory where output tarball and temporary output files are stored  (default: `/tmp`)
* `--tarball-name <TARBALL_NAME>`: Filename (without .tar.gz) for the output tarball (default: `tedge-diag_<timestamp>`)
* `--timeout <TIME>`: Timeout for each plugin's execution (default: 10s) 

#### Note
`collect` is the only subcommand as of now. Can be more in the future.

### Directory hierarchy example
```
/tmp/
├─ tedge-diag_20250404235840.tar.gz
├─ tedge-diag_20250404235840/
│  ├─ 001_tedge/
│  │  ├─ 001_tedge.out
│  │  ├─ 001_tedge.err
│  │  ├─ tedge-agent.log
│  │  ├─ ...
/etc/tedge/diag-plugins/
├─ 001_tedge
├─ 002_mosquitto
├─ ...
```

## Diagnostic plugin's responsibility
* Plugin must be an executable.
* Plugin is called by the runner with arguments (see runner's spec).
* Plugin should output to the given directory provided by the argument. (with `--output-dir <DIR>`)
* Plugin should exit before the timeout and return with respectful exit code.
