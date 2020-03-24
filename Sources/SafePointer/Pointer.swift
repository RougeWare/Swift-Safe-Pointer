//
//  Pointer.swift
//  SafePointer
//
//  Created by Ben Leggiero on 2019-08-11.
//  Copyright © 2019 Blue Husky Studios BH-0-PD
//  https://github.com/BlueHuskyStudios/Licenses/blob/master/Licenses/BH-0-PD.txt
//

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
