//
//  File.swift
//  
//
//  Created by Thorax on 19.07.2020.
//

import XCTest
@testable import JSONtoCSVcore

final class CSVTests: XCTestCase {
    func test_json_with_delimiters() {
        let dict = ["String": "String with separator, and delimiter\n"]
        let json = JSON(dict: dict)
        let csv = CSV(json: json)
        XCTAssertEqual(csv.string, "String\n\"String with separator, and delimiter\n\"")
    }
    
    func test_json_containing_array() {
        let dict = ["Array": ["1", "2"]]
        let json = JSON(dict: dict)
        let csv = CSV(json: json)
        XCTAssertEqual(csv.string, "Array/0,Array/1\n1,2")
    }
    
    func test_json_containing_dictionary() {
        let dict = ["Dict": ["k1": "a", "k2": "b"]]
        let json = JSON(dict: dict)
        let csv = CSV(json: json)
        XCTAssertEqual(csv.string, "Dict/k1,Dict/k2\na,b")
    }
    
    func test_json_with_complex_data() {
        let dict: [String: Any] = [
            "Array": ["1", "2"],
            "Dict": ["k1": "a", "k2": "b"],
            "Key": "Value",
            "Boolean": true
        ]
        let json = JSON(dict: dict)
        let csv = CSV(json: json)
        XCTAssertEqual(csv.string, "Array/0,Array/1,Boolean,Dict/k1,Dict/k2,Key\n1,2,true,a,b,Value")
    }
}
