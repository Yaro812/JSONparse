//
//  CSV.swift
//  
//
//  Created by Thorax on 19.07.2020.
//

import Files
import Foundation

private let defaultDelimiter = "\n"
private let defaultSeparator = ","

struct CSV {
    enum Error: Swift.Error {
        case dataIsNotConvertibleToString
        case stringIsNotAValidCSV
    }
    
    let string: String
    let delimiter: String
    let separator: String
    
    init(path: String, delimiter: String = defaultDelimiter, separator: String = defaultSeparator) throws {
        let file = try File(path: path)
        let data = try file.read()
        try self.init(data: data, delimiter: delimiter, separator: separator)
    }
    
    init(data: Data, delimiter: String, separator: String) throws {
        guard let string = String(bytes: data, encoding: .utf8) else {
            throw Error.dataIsNotConvertibleToString
        }
        
        try self.init(string: string, delimiter: delimiter, separator: separator)
    }
    
    init(string: String, delimiter: String, separator: String) throws {
        func isValidCSV(string: String) -> Bool {
            return true
        }
        
        guard isValidCSV(string: string) else {
            throw Error.stringIsNotAValidCSV
        }
        
        self.string = string
        self.delimiter = delimiter
        self.separator = separator
    }
    
    init(json: JSON, delimiter: String = defaultDelimiter, separator: String = defaultSeparator) {
        func sane(value: String) -> String {
            guard !(value.contains(delimiter) || value.contains(separator) || value.contains(" ")) else {
                return "\"\(value)\""
            }
            return value
        }
        
        var result = ""
        if let array = json.dictArray, array.threshhold > 0.7 {
            print("Creating CSV from an array of dictionaries")
            print("Threshold: \(array.threshhold)")
            print("Keys are: \(array.keys)")
            let keys = array.keys
            let dicts = array.dictionaries
            result += keys.joined(separator: separator)
            result += delimiter
            for dict in dicts {
                var string = ""
                for key in keys {
                    if let value = dict[key] {
                        string += sane(value: "\(value)")
                    }
                    string += separator
                }
                string = String(string.dropLast())
                result += string
                result += delimiter
            }
            result = String(result.dropLast())
        } else {
            switch json.flattened() {
            case let .array(array):
                print("Creating CSV from array")
                let keys = (0..<array.count).map { "\($0)" }
                result += keys.joined(separator: separator)
                result += delimiter
                let values = array.map { sane(value: "\($0)") }
                result += values.joined(separator: separator)
            case let .dict(dict):
                print("Creating CSV from dictionary")
                let keys = dict.keys.sorted()
                result += keys.joined(separator: separator)
                result += delimiter
                let values = keys.map { "\(dict[$0]!)" }
                let saneValues = values.map(sane)
                result += saneValues.joined(separator: separator)
            }
        }
        
        self.string = result
        self.delimiter = delimiter
        self.separator = separator
    }
    
    func save(to path: String) throws {
        var components = path.split(separator: "/").map { String($0) }
        let fileName = components.last ?? path
        
        components.removeLast()
        let folderPath = components.joined(separator: "/")
        let folder = try Folder(path: folderPath)
        let file = try folder.createFileIfNeeded(at: fileName)
        try file.write(string)
    }
}
