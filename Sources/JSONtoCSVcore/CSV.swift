//
//  File.swift
//  
//
//  Created by Thorax on 19.07.2020.
//

import Files
import Foundation

struct CSV {
    enum Error: Swift.Error {
       
    }
    
    let string: String
    
    init(json: JSON, delimiter: String = "\n", separator: String = ",") {
        var result = ""
        switch json.flattened {
        case let .array(array):
            let keys = (0..<array.count).map { "\($0)" }
            result += keys.joined(separator: separator)
            result += delimiter
            let values = array.map { "\($0)" }
                result += values.joined(separator: separator)
        case let .dict(dict):
            let keys = dict.keys
            result += keys.joined(separator: separator)
            result += delimiter
            let values = keys.map { "\(dict[$0]!)" }
            result += values.joined(separator: separator)
        }
        string = result
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
