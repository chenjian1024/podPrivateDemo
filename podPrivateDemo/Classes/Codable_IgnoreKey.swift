//
//  Codable_IgnoreKey.swift
//
//  Created by chenjian on 2021/9/27.
//  Copyright © 2021 chenjian. All rights reserved.
//

@propertyWrapper
struct IgnoreKey<T> {
    private var value: T?
    
    var wrappedValue: T? {
        get { value }
        set {
            self.value = newValue
        }
    }
    public init(wrappedValue: T?) {
        self.value = wrappedValue
    }
}

extension IgnoreKey: Codable {
    public func encode(to encoder: Encoder) throws {
        // 忽略encode过程
    }
    
    public init(from decoder: Decoder) throws {
        // 忽略decoder过程
    }
}
