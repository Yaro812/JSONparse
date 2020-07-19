//
//  JSONtoCSV.swift
//  
//
//  Created by Thorax on 19.07.2020.
//

import Foundation
import Rainbow
import ShellOut

enum JSONtoCSVError: Error {
    case argumentsMissing
}

public final class JSONtoCSV {
    private let arguments: [String]
    
    var isHelpNeeded: Bool { return arguments.contains("-h") || arguments.contains("--help") }
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else { throw JSONtoCSVError.argumentsMissing }
        
        if isHelpNeeded {
            help()
        } else {
            try convert()
        }
    }
    
    private func defaultFilePath(from path: String) -> String {
        return path.replacingOccurrences(of: ".json", with: ".csv")
    }
    
    
    private func help() {
        print("\nThis script will convert a given JSON file to CSV format\n")
        print("Usage: from script folder type")
        print("swift run JSONtoCSV <pathTo/originalFile.json> <pathTo/resultingFile.csv".yellow)
        print("You can omit the resulting file parameter. In that case the csv file will be created with the name of the original file and csv extension")
        let example = "swift run JSONtoCSV ../myFile.json ../myConvertedFile.csv\nswift run JSONtoCSV ../myFile.json".white
        print("Examples: \(example)")
    }
    
    private func convert() throws {
        let filePath = arguments[1]
        let destinationPath = arguments.count > 2 ? arguments[2] : defaultFilePath(from: filePath)
        
        print("Reading file from \(filePath.white)")
        let json = try JSON(path: filePath)
        let csv = CSV(json: json)
        print("Saving CSV string containing \(String(describing: csv.string.count).yellow) symbols to \(destinationPath.white)")
        try csv.save(to: destinationPath)
        
        print("Script executed".green)
    }
}
