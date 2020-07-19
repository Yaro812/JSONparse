//
//  JSONtoCSV.swift
//  
//
//  Created by Thorax on 19.07.2020.
//

import Foundation

public final class JSONtoCSV {
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        print("Script executed")
    }
}
