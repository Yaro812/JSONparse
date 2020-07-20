//
//  Created by Thorax on 19.07.2020.
//

//let tool = JSONtoCSV()
//
//do {
//    try tool.run()
//} catch {
//    print("An error occured: \(error)".red)
//}

import ArgumentParser
import JSONparseCore

struct Jsonparse: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to parse JSON files to different formats",
        subcommands: [])

    @Argument(help: "Path to the JSON file")
    private var filePath: String

    @Option(name: .shortAndLong, help: "The key to start parsing from")
    var key: String?

    @Flag(name: .shortAndLong, help: "Generate CSV file from the JSON")
    private var csv = false

    @Flag(name: .shortAndLong, help: "Generate SQL file from the JSON")
    private var sql = false

    mutating func run() throws {
        if csv {
            let process = JSONtoCSV(filePath: filePath, startKey: key)
            try process.run()
        }
        if sql {
            print("Parsing to SQL not yet implemented")
        }
    }
}

Jsonparse.main()
