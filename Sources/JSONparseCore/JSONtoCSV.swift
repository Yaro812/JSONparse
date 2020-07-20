//
//  JSONtoCSV.swift
//  
//
//  Created by Thorax on 19.07.2020.
//

import Foundation
import Rainbow

enum JSONtoCSVError: Error {
    case argumentsMissing
}

public final class JSONtoCSV {
    var filePath: String
    var startKey: String?

    public init(filePath: String, startKey: String?) {
        self.filePath = filePath
        self.startKey = startKey
    }
    
    public func run() throws {
        try convert()
    }
    
    private func defaultFilePath(from path: String) -> String {
        return path.replacingOccurrences(of: ".json", with: ".csv")
    }
    
    private func convert() throws {
        let destinationPath = defaultFilePath(from: filePath)
        
        print("Reading file from \(filePath.white)")
        var json = try JSON(path: filePath)
        if let startKey = startKey, case let .dict(dict) = json  {
            if let value = dict[startKey] {
                json = try JSON(value)
            }
       }
        let csv = CSV(json: json)
        print("Saving CSV string containing \(String(describing: csv.string.count).yellow) symbols to \(destinationPath.white)")
        try csv.save(to: destinationPath)
        
        print("Script executed".green)
    }
}
