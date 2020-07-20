//
//  File.swift
//  
//
//  Created by Thorax on 19.07.2020.
//

import XCTest
@testable import JSONtoCSVcore

final class JSONTests: XCTestCase {
    func test_json_uniform_dictionaries() throws {
        let dict = [["k1": "a", "k2": "b"], ["k1": "c", "k2": "d"]]
        let json = try JSON(dict)
        let uniform = json.uniformDictArray
        XCTAssertNotNil(uniform)
        XCTAssertEqual(uniform!.keys, ["k1", "k2"])
    }
    
    func test_json_non_uniform_dictionaries() throws {
        let dict = [["k1": "a", "k2": "b"], ["k3": "c", "k2": "d"]]
        let json = try JSON(dict)
        let uniform = json.uniformDictArray
        XCTAssertNil(uniform)
    }
    
    func test_json_array_dictionaries() throws {
        let dict = [["k1": "a", "k2": "b"], ["k3": "c", "k2": "d"]]
        let json = try JSON(dict)
        let dictArray = json.dictArray
        XCTAssertNotNil(dictArray)
        XCTAssertEqual(dictArray!.keys, ["k1", "k2", "k3"])
    }
}
