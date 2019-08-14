//
//  SafePointer.swift
//  SafePointer
//
//  Created by Ben Leggiero on 2019-08-11.
//  Copyright © 2019 Blue Husky Studios BH-0-PD
//  https://github.com/BlueHuskyStudios/Licenses/blob/master/Licenses/BH-0-PD.txt
//



// MARK: - Pointer protocol

/// Lets you pass anything using reference semantics without the danger of unsafe pointers.
///
/// Do note that this is more of a conceptual pointer; one which points to some intance. This acknowledges no concept
/// of memory addresses nor traversing memory. For that, you can use Swift's built-in `UnsafePointer` and its sisters.
public protocol Pointer: class {
    
    /// The type of the instance that this pointer points to
    associatedtype Pointee
    
    
    
    /// The instance this pointer points to
    var pointee: Pointee { get }
    
    
    /// Creates a new pointer and points it at the given instance
    ///
    /// - Parameter pointee: The instance to which this pointer will point
    init(to pointee: Pointee)
}



// MARK: - MutablePointer protocol

/// A `Pointer` which can be changed to point at some other instance
public protocol MutablePointer: Pointer {
    
    /// The instance this pointer points to
    var pointee: Pointee { get set }
    
    /// Creates a new pointer, points it at the given instance, and sets up a change listener
    ///
    /// - Parameters:
    ///   - pointee:            The instance to which this pointer will point
    ///   - onPointeeDidChange: _optional_ - Called immediately after `pointee` changes
    init(to pointee: Pointee, onPointeeDidChange: @escaping OnPointeeDidChange)
    
    
    
    /// The kind of function which can respond to a pointee changing
    ///
    /// - Parameters:
    ///   - oldValue: A snapshot of what `pointee` was before it changed
    ///   - newValue: A snapshot of what `pointee` was after it changed
    typealias OnPointeeDidChange = (_ oldValue: Pointee, _ newValue: Pointee) -> Void
}



// MARK: - SafePointer

/// A pointer which carries no danger in its use. If there's a crash, it won't be `SafePointer`'s fault!
@propertyWrapper
public class SafePointer<Value>: Pointer {
    
    /// This is so the pass-by-reference semantics make sense to the Swift compiler
    fileprivate var _pointee: Value
    
    public var pointee: Value { _pointee }
    
    
    public required init(to pointee: Value) {
        self._pointee = pointee
    }
    
    
    // MARK: Property wrapper
    
    /// The same a `pointee`
    public var wrappedValue: Value { pointee }
    
    
    /// The same as `.init(to:)`
    ///
    /// - Parameter wrappedValue: The pointee
    public convenience init(wrappedValue: Value) {
        self.init(to: wrappedValue)
    }
}


// MARK: - MutableSafePointer

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
    
    override public var wrappedValue: Value { self.pointee }
    
    public convenience init(wrappedValue: Value) {
        self.init(to: wrappedValue)
    }
}
