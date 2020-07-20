import XCTest
import class Foundation.Bundle

final class JSONparseTests: XCTestCase {
    @available(macOS 10.13, *)
    func standardProcess(arguments: String) -> Process {
        let fooBinary = productsDirectory.appendingPathComponent("JSONparse")

        let process = Process()
        process.arguments = [arguments]
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe
        
        return process
    }
    
    func standardOutput(for process: Process) -> String? {
        guard let pipe = process.standardOutput as? Pipe else { return nil }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        return output
    }

    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testExecutionResult", testExecutionResult),
    ]
}
