//
//  ObservableMutableSafePointer.swift
//  SafePointer
//
//  Created by Ben Leggiero on 2020-03-22.
//  Copyright © 2020 Blue Husky Studios BH-0-PD
//  https://github.com/BlueHuskyStudios/Licenses/blob/master/Licenses/BH-0-PD.txt
//

/// A mutable pointer which carries no danger in its use, and whose changes can be safely observed by many things.
/// If there's a crash, it won't be `ObservableMutableSafePointer`'s fault!
@propertyWrapper
public final class ObservableMutableSafePointer<Value>: SafePointer<Value>, MutablePointer {
    
    override public var pointee: Value {
        get { _pointee }
        set {
            let oldValue = _pointee
            _pointee = newValue
            onPointeeDidChangeQueue.forEach { $0.observer(oldValue, newValue) }
        }
    }
    
    
    /// The queue of functions which will be called after `pointee` changes.
    ///
    /// Guaranteed to be called in the order in which the observers were added
    private var onPointeeDidChangeQueue: AddedObservers = []
//    private var indexCache: [ObserverIdentifier : AddedObservers.Index] = [:] // TODO: Use something like this to efficiently remove an observer
    
    
    /// Creates a new observable, mutable, safe pointer to the given value
    ///
    /// - Parameters:
    ///   - pointee:               The value to point to
    ///   - newObserverIdentifier: _optional_ - The identifier for the observer. You can use this later to remove the
    ///                            observer. Pass any value (I recommend `ObserverIdentifier()`), and after this
    ///                            initializer completes, it will have been set to the observer identifier. The initial
    ///                            value you pass in will be ignored.
    ///   - onPointeeDidChange:    A function which will be called when the pointee changes
    public init(to pointee: Value, newObserverIdentifier: inout ObserverIdentifier, onPointeeDidChange: @escaping OnPointeeDidChange) {
        super.init(to: pointee)
        newObserverIdentifier = addObserver(onPointeeDidChange)
    }
    
    
    /// Creates a new observable, mutable, safe pointer to the given value
    ///
    /// - Parameters:
    ///   - pointee:               The value to point to
    ///   - newObserverIdentifier: _optional_ - The identifier for the observer. You can use this later to remove the
    ///                            observer. Pass any value (I recommend `ObserverIdentifier()`), and after this
    ///                            initializer completes, it will have been set to the observer identifier.
    ///   - onPointeeDidChange:    A function which will be called when the pointee changes
    public init(to pointee: Value, onPointeeDidChange: @escaping OnPointeeDidChange) {
        super.init(to: pointee)
        addObserver(onPointeeDidChange)
    }
    
    
    /// Creates a new observable, mutable, safe pointer to the given value
    ///
    /// - Parameter pointee: The value to point to
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



// MARK: - Observation

public extension ObservableMutableSafePointer {
    
    /// Adds the given function to be called whenever this pointer changes.
    ///
    /// When this pointer goes out of scope, all of its observers are automatically and immediately removed. If you
    /// don't intend to remove the observer before this pointer goes out of scope, then you can ignore the return value
    ///
    /// - Parameter onPointeeDidChange: The function to be called when the pointee changes
    /// - Returns: _optional_ - The identifier for the observer. You can use this later to remove the observer.
    @discardableResult
    func addObserver(_ onPointeeDidChange: @escaping OnPointeeDidChange) -> ObserverIdentifier {
        let identifier = ObserverIdentifier.random(in: .min ... .max)
        self.onPointeeDidChangeQueue.append((identifier: identifier, observer: onPointeeDidChange))
//        indexCache[identifier] = self.onPointeeDidChangeQueue.endIndex.advanced(by: -1)
        return identifier
    }
    
    
    /// Removes the observer which has the given identifier
    ///
    /// If the given identifier refers to an observer which was already removed (or which was never added at all),
    /// nothing special happens; this just returns `.observerNotFound`.
    ///
    /// If an observer is removed before it finishes running, this class doesn't try to stop it nor hold onto it.
    ///
    /// - Complexity: O(n)
    ///
    /// See https://github.com/RougeWare/Swift-Safe-Pointer/issues/8
    ///
    /// - Parameter identifier: The identifier which corresponds to a function you want to remove
    /// - Returns: _optional_ - `.removedSuccessfully` iff an observer with the given identifier was found and removed.
    ///                         Otherwise, `.observerNotFound`.
    @discardableResult
    func removeObserver(withId identifier: ObserverIdentifier) -> RemoveObserverResult {
        guard let index = onPointeeDidChangeQueue.firstIndex(where: { $0.identifier == identifier }) else {
            return .observerNotFound
        }
        
        onPointeeDidChangeQueue.remove(at: index)
//        indexCache.removeValue(forKey: identifier)
        return .removedSuccessfully
    }
    
    
    
    /// An observer that's been added to the observer queue, and its corresponding identifier
    fileprivate typealias AddedObserver = (identifier: ObserverIdentifier, observer: OnPointeeDidChange)
    
    /// The type of collection this uses to track added observers
    fileprivate typealias AddedObservers = [AddedObserver]
    
    
    
    /// The result of attempting to remove an observer
    enum RemoveObserverResult {
        
        /// The observer was found and removed from the observer queue
        case removedSuccessfully
        
        /// The observer was not found, so no action was taken
        case observerNotFound
    }
}



/// The type of identifier used to identify a function that's been added to the observer queue
public typealias ObserverIdentifier = Int


                                                                                           // OMS   P
public typealias MutableSafeObservablePointer<Value> = ObservableMutableSafePointer<Value> //  MSO  P
public typealias SafeObservableMutablePointer<Value> = ObservableMutableSafePointer<Value> //   SOM P
public typealias MutableObservableSafePointer<Value> = ObservableMutableSafePointer<Value> // MOS   P
public typealias ObservableSafeMutablePointer<Value> = ObservableMutableSafePointer<Value> //  OSM  P
public typealias SafeMutableObservablePointer<Value> = ObservableMutableSafePointer<Value> //   SMO P

