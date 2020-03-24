//
//  MutablePointer.swift
//  SafePointer
//
//  Created by Ben Leggiero on 2019-08-11.
//  Copyright © 2019 Blue Husky Studios BH-0-PD
//  https://github.com/BlueHuskyStudios/Licenses/blob/master/Licenses/BH-0-PD.txt
//

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
