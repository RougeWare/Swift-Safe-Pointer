//
//  SafePointer.swift
//  SafePointer
//
//  Created by Ben Leggiero on 2019-08-11.
//  Copyright © 2019 Blue Husky Studios BH-0-PD
//  https://github.com/BlueHuskyStudios/Licenses/blob/master/Licenses/BH-0-PD.txt
//

/// A pointer which carries no danger in its use. If there's a crash, it won't be `SafePointer`'s fault!
@propertyWrapper
public class SafePointer<Value>: Pointer {
    
    /// This is so the pass-by-reference semantics make sense to the Swift compiler
    internal var _pointee: Value
    
    public var pointee: Value { _pointee }
    
    
    public required init(to pointee: Value) {
        self._pointee = pointee
    }
    
    
    // MARK: Property wrapper
    
    /// The same as `pointee`
    public var wrappedValue: Value { pointee }
    
    
    /// The same as `.init(to:)`
    ///
    /// - Parameter wrappedValue: The pointee
    public convenience init(wrappedValue: Value) {
        self.init(to: wrappedValue)
    }
}
