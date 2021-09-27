//
//  CodableDefaultValue_Extension.swift
//  gy
//
//  Created by chenjian on 2021/9/27.
//  Copyright © 2020 chenjian. All rights reserved.
//

import UIKit

protocol DefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

extension Bool {
    enum False: DefaultValue {
        static let defaultValue = false
    }
    enum True: DefaultValue {
        static let defaultValue = true
    }
}

@propertyWrapper

struct Default<T: DefaultValue> {
    var wrappedValue: T.Value
}

extension Default {
    typealias True = Default<Bool.True>
    typealias False = Default<Bool.False>
}

// decode process
extension Default: Codable {
    init(from decoder: Decoder) throws {
        let containner = try decoder.singleValueContainer()
        wrappedValue = (try? containner.decode(T.Value.self)) ?? T.defaultValue
    }
}

// encode process
extension KeyedDecodingContainer {
    func decode<T>(_ type: Default<T>.Type,
                   forKey key: Key) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}
