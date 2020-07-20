# JSONparse

Swift command-line tool to parse JSON files to different formats

## Usage

You need to pass the path to the JSON file. It will be parsed in original file folder with the desired format and extension
```
jsonparse <file-path> [--key <key>] [--csv] [--sql]
```
Currently only csv export is supported

Example:
```
swift run jsonparse ../myFile.json -csv
```
will result in creation of
```
../myFile.csv
```

## Installation

Currently only SPM is supported

### Swift Package Manager

```
.package(url: "https://github.com/Yaro812/JSONtoCSV", from: "1.0.0")
```
