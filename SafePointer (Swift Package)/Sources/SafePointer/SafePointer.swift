//
//  SafePointer.swift
//  SafePointer
//
//  Created by Ben Leggiero on 2019-08-11.
//  Copyright © 2019 Blue Husky Studios BH-0-PD
//  https://github.com/BlueHuskyStudios/Licenses/blob/master/Licenses/BH-0-PD.txt
//

@propertyWrapper
public class SafePointer<Value> {
    public let wrappedValue: Value
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}
