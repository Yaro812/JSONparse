# JSONtoCSV

This script will convert a given JSON file to CSV format

## Usage

From script folder type
```
swift run JSONtoCSV <pathTo/originalFile.json> <pathTo/resultingFile.csv> <starting dictionary key>
```
You can omit the resulting file parameter. In that case the csv file will be created with the name of the original file and csv extension
Example:
```
swift run JSONtoCSV ../myFile.json ../myConvertedFile.csv parameter
```

## Instalation

Currently only SPM is supported

### Swift Package Manager

```
.package(url: "https://github.com/Yaro812/JSONtoCSV", from: "1.0.0")
```
