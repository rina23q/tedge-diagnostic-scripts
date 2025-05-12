# tedge-diagnostic-scripts
PoC for the thin-edge diagnostic feature

## Usage:
```shell
git clone https://github.com/rina23q/tedge-diagnostic-scripts.git
cd tedge-diagnostic-scripts
./runner.sh collect --plugin-dir ./plugins-legacy
```

## Check output
```shell
$ ls -ltr ./output/
total 216
drwxrwxr-x 2 rina rina   4096 Apr  4 23:58 tmp
-rw-rw-r-- 1 rina rina 215277 Apr  4 23:58 tedge-diagnostics_20250404235840.tar.gz
```

## Help message of runner.sh
```
$ ./runner.sh --help
Usage: ./runner.sh <command> [options]

Commands:
  collect             Run all plugins and create a diagnostics tarball
  help                Show this help message and exit

Options (for 'collect' command):
  --plugin-dir DIR    Directory containing plugin scripts (default: ./plugins)
  --output-dir DIR    Directory to save diagnostic output (default: ./output)

Description:
  The 'collect' command runs all executable plugin scripts in the specified
  plugin directory with the 'collect' argument. It saves the output to files
  under a temporary directory and creates a tarball of the collected results.

```