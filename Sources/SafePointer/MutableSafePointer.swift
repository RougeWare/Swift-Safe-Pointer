//
//  MutableSafePointer.swift
//  SafePointer
//
//  Created by Ben Leggiero on 2019-08-11.
//  Copyright © 2019 Blue Husky Studios BH-0-PD
//  https://github.com/BlueHuskyStudios/Licenses/blob/master/Licenses/BH-0-PD.txt
//

/// A mutable pointer which carries no danger in its use. If there's a crash, it won't be `MutableSafePointer`'s fault!
@propertyWrapper
public final class MutableSafePointer<Value>: SafePointer<Value>, MutablePointer {
    
    override public var pointee: Value {
        get { _pointee }
        set {
            let oldValue = _pointee
            _pointee = newValue
            onPointeeDidChange?(oldValue, newValue)
        }
    }
    
    
    /// The function which will be called after `pointee` changes
    private var onPointeeDidChange: OnPointeeDidChange?
    
    
    public init(to pointee: Value, onPointeeDidChange: @escaping OnPointeeDidChange) {
        super.init(to: pointee)
        self.onPointeeDidChange = onPointeeDidChange
    }
    
    
    public required init(to pointee: Value) {
        super.init(to: pointee)
    }
    
    
    // MARK: Property wrapper
    
    override public var wrappedValue: Value {
        get { self.pointee }
        set { self.pointee = newValue }
    }
    
    public convenience init(wrappedValue: Value) {
        self.init(to: wrappedValue)
    }
}



public typealias SafeMutablePointer<Value> = MutableSafePointer<Value>
