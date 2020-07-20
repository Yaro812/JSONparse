//
//  JSON.swift
//  
//
//  Created by Thorax on 19.07.2020.
//

import Files
import Foundation
import Rainbow

enum JSON {
    enum Error: Swift.Error {
        case notConvertibleToJSON
    }
    
    struct DictArray {
        let dictionaries: [[String: Any]]
        let keys: [String]
        
        /// a coefficient of how similar are the keys in the dictionaries
        /// 0 would mean no similarities, 1 means that all dictionaries have the same keys
        var threshhold: Double {
            let first = dictionaries[0]
            return Double(first.keys.count) / Double(keys.count)
        }
        
        /// all dictionaries have the same keys in them
        var isUniform: Bool {
            return threshhold < 1 + Double.ulpOfOne && threshhold > 1 - Double.ulpOfOne
        }
        
        init?(array: [Any]) {
            guard let dictArray = array as? [[String: Any]] else { return nil }
            guard dictArray.count > 1 else { return nil }
            
            var keys: Set<String> = []
            dictArray.forEach { dict in dict.keys.forEach { keys.insert($0) } }
            self.keys = Array(keys).sorted()
            self.dictionaries = dictArray
        }
    }
    
    case dict([String: Any])
    case array([Any])
    
    var count: Int {
        switch self {
        case let .dict(x):
            return x.keys.count
        case let .array(x):
            return x.count
        }
    }
    
    var uniformDictArray: DictArray? {
        guard let dictArray = self.dictArray, dictArray.isUniform else { return nil }
      
        return dictArray
    }
    
    var dictArray: DictArray? {
         guard case let .array(array) = self else { return nil }
        
        return DictArray(array: array)
    }
    
    var value: Any {
        switch self {
        case let .dict(dict):
            return dict
        case let .array(array):
            return array
        }
    }
    
    init(path: String) throws {
        let file = try File(path: path)
        let data = try file.read()
        try self.init(data: data)
    }
    
    init(data: Data) throws {
        let object = try JSONSerialization.jsonObject(with: data, options: [])
        try self.init(object)
    }
    
    init(dict: [String: Any]) {
        self = .dict(dict)
    }
    
    init(array: [Any]) {
        self = .array(array)
    }
    
    init(_ value: Any) throws {
        switch value {
        case let dict as NSDictionary:
            self = .dict(dict as! [String: Any])
        case let array as NSArray:
            self = .array(array as! [Any])
        case let dict as [String: Any]:
            self = .dict(dict)
        case let array as [Any]:
            self = .array(array)
        default:
            throw Error.notConvertibleToJSON
        }
    }
    
    func dictArray(threshold: Double) -> DictArray? {
        guard let dictArray = self.dictArray, dictArray.threshhold >= threshold else { return nil }
        
        return dictArray
    }
    
    func flattened() -> JSON {
        let elements = "\(count)".yellow
        print("Flattening json containing \(elements) elements")
        var result: [String: Any] = [:]
        
        func flatten(item: Any, name: String) {
            switch item {
            case let dict as [String: Any]:
                dict.keys.forEach { key in flatten(item: dict[key]!, name: name + key + "/") }
            case let array as [Any]:
                array.enumerated().forEach { index, item in flatten(item: item, name: name + "\(index)" + "/") }
            default:
                let key = String(name.dropLast())
                result[key] = item
            }
        }
        
        flatten(item: value, name: "")
        let flattenedElements = "\(result.keys.count)".yellow
        print("Flattened json contains \(flattenedElements) elements")
        return JSON(dict: result)
    }
}
