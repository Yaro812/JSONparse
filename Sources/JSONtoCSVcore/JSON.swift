//
//  File.swift
//  
//
//  Created by Thorax on 19.07.2020.
//

import Files
import Foundation

enum JSON {
    enum Error: Swift.Error {
        case notConvertibleToJSON
    }
    
    case dict([String: Any])
    case array([Any])
    
    var flattened: JSON {
        return self
    }
    
    init(path: String) throws {
        let file = try File(path: path)
        let data = try file.read()
        try self.init(data)
    }
    
    init(_ data: Data) throws {
        let object = try JSONSerialization.jsonObject(with: data, options: [])
        switch object {
        case let dict as NSDictionary:
            self = .dict(dict as! [String: Any])
        case let array as NSArray:
            self = .array(array as! [Any])
        default:
            throw Error.notConvertibleToJSON
        }
    }
    
    init(_ dict: [String: Any]) {
        self = .dict(dict)
    }
    
    init(_ array: [Any]) {
        self = .array(array)
    }
    
    private func flattenJSON(_ json: JSON) -> JSON {
         var result: [String: Any] = [:]
         
//         func flatten(item: Any, name: String) -> [String: Any] {
//             
//         }
         
//         flatten(item: json, name: "")
         return JSON(result)
     }
}
