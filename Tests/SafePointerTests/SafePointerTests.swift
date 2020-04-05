//
//  SafePointerTests.swift
//  SafePointerTests
//
//  Created by Ben Leggiero on 2019-08-11.
//  Copyright © 2019 Blue Husky Studios BH-0-PD
//  https://github.com/BlueHuskyStudios/Licenses/blob/master/Licenses/BH-0-PD.txt
//

import XCTest
@testable import SafePointer



final class SafePointerTests: XCTestCase {
    
    func testPassingStructByReference() {
        let value = PassByValue(innerValue: 0)
        let reference = SafePointer(to: value)
        let referenceCopyA = reference
        let referenceCopyB = reference
        
        XCTAssertEqual(reference.pointee,
                       referenceCopyA.pointee)
        XCTAssertEqual(referenceCopyA.pointee,
                       referenceCopyB.pointee)
        XCTAssertEqual(reference.pointee.innerValue,
                       referenceCopyA.pointee.innerValue)
        XCTAssertEqual(referenceCopyA.pointee.innerValue,
                       referenceCopyB.pointee.innerValue)
        
        XCTAssertNotEqual(withUnsafePointer(to: value, {$0}),
                          withUnsafePointer(to: reference.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee, {$0}))
        XCTAssertNotEqual(withUnsafePointer(to: value.innerValue, {$0}),
                          withUnsafePointer(to: reference.pointee.innerValue, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.innerValue, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.innerValue, {$0}))
    }
    
    
    func testPassingNestedStructByReference() {
        let value = PassByValueParent(child: PassByValueParent.Child(innerValue: 0))
        let reference = SafePointer(to: value)
        let referenceCopyA = reference
        let referenceCopyB = reference
        
        XCTAssertEqual(reference.pointee,
                       referenceCopyA.pointee)
        XCTAssertEqual(referenceCopyA.pointee,
                       referenceCopyB.pointee)
        XCTAssertEqual(reference.pointee.child,
                       referenceCopyA.pointee.child)
        XCTAssertEqual(referenceCopyA.pointee.child,
                       referenceCopyB.pointee.child)
        XCTAssertEqual(reference.pointee.child.innerValue,
                       referenceCopyA.pointee.child.innerValue)
        XCTAssertEqual(referenceCopyA.pointee.child.innerValue,
                       referenceCopyB.pointee.child.innerValue)
        
        XCTAssertNotEqual(withUnsafePointer(to: value, {$0}),
                          withUnsafePointer(to: reference.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee, {$0}))
        XCTAssertNotEqual(withUnsafePointer(to: value.child, {$0}),
                          withUnsafePointer(to: reference.pointee.child, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.child, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.child, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.child, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.child, {$0}))
        XCTAssertNotEqual(withUnsafePointer(to: value.child.innerValue, {$0}),
                          withUnsafePointer(to: reference.pointee.child.innerValue, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.child.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.child.innerValue, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.child.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.child.innerValue, {$0}))
        
        XCTAssertTrue(reference === referenceCopyA)
        XCTAssertTrue(referenceCopyA === referenceCopyB)
    }
    
    
    func testMutatingStructByReference() {
        let value = PassByValue(innerValue: 0)
        let reference = MutableSafePointer(to: value)
        let referenceCopyA = reference
        let referenceCopyB = reference
        
        XCTAssertEqual(reference.pointee,
                       referenceCopyA.pointee)
        XCTAssertEqual(referenceCopyA.pointee,
                       referenceCopyB.pointee)
        XCTAssertEqual(reference.pointee.innerValue,
                       referenceCopyA.pointee.innerValue)
        XCTAssertEqual(referenceCopyA.pointee.innerValue,
                       referenceCopyB.pointee.innerValue)
        
        XCTAssertEqual(withUnsafePointer(to: reference.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.innerValue, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.innerValue, {$0}))
        
        
        reference.pointee.innerValue = 42
        
        XCTAssertEqual(reference.pointee,
                       referenceCopyA.pointee)
        XCTAssertEqual(referenceCopyA.pointee,
                       referenceCopyB.pointee)
        XCTAssertEqual(reference.pointee.innerValue,
                       referenceCopyA.pointee.innerValue)
        XCTAssertEqual(referenceCopyA.pointee.innerValue,
                       referenceCopyB.pointee.innerValue)
        
        XCTAssertEqual(withUnsafePointer(to: reference.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.innerValue, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.innerValue, {$0}))
    }
    
    
    func testMutatingStructWithPropertyWrapper() {
        let value = HasMutableSafePointerAsPropertyWrapper(innerValue: 0)
        
        XCTAssertEqual(0, value.innerValue)
        
        value.innerValue = 42
        
        XCTAssertEqual(42, value.innerValue)
    }
    
    
    func testMutatingNestedStructByReference() {
        let value = PassByValueParent(child: PassByValueParent.Child(innerValue: 0))
        let reference = MutableSafePointer(to: value)
        let referenceCopyA = reference
        let referenceCopyB = reference
        
        XCTAssertEqual(reference.pointee,
                       referenceCopyA.pointee)
        XCTAssertEqual(referenceCopyA.pointee,
                       referenceCopyB.pointee)
        XCTAssertEqual(reference.pointee.child,
                       referenceCopyA.pointee.child)
        XCTAssertEqual(referenceCopyA.pointee.child,
                       referenceCopyB.pointee.child)
        XCTAssertEqual(reference.pointee.child.innerValue,
                       referenceCopyA.pointee.child.innerValue)
        XCTAssertEqual(referenceCopyA.pointee.child.innerValue,
                       referenceCopyB.pointee.child.innerValue)
        
        XCTAssertEqual(withUnsafePointer(to: reference.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.child, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.child, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.child, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.child, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.child.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.child.innerValue, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.child.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.child.innerValue, {$0}))
        
        
        reference.pointee.child.innerValue = 42
        
        XCTAssertEqual(reference.pointee,
                       referenceCopyA.pointee)
        XCTAssertEqual(referenceCopyA.pointee,
                       referenceCopyB.pointee)
        XCTAssertEqual(reference.pointee.child,
                       referenceCopyA.pointee.child)
        XCTAssertEqual(referenceCopyA.pointee.child,
                       referenceCopyB.pointee.child)
        XCTAssertEqual(reference.pointee.child.innerValue,
                       referenceCopyA.pointee.child.innerValue)
        XCTAssertEqual(referenceCopyA.pointee.child.innerValue,
                       referenceCopyB.pointee.child.innerValue)
        
        XCTAssertEqual(withUnsafePointer(to: reference.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.child, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.child, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.child, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.child, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.child.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.child.innerValue, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.child.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.child.innerValue, {$0}))
        
        
        reference.pointee.child = PassByValueParent.Child(innerValue: -1)
        
        XCTAssertEqual(reference.pointee,
                       referenceCopyA.pointee)
        XCTAssertEqual(referenceCopyA.pointee,
                       referenceCopyB.pointee)
        XCTAssertEqual(reference.pointee.child,
                       referenceCopyA.pointee.child)
        XCTAssertEqual(referenceCopyA.pointee.child,
                       referenceCopyB.pointee.child)
        XCTAssertEqual(reference.pointee.child.innerValue,
                       referenceCopyA.pointee.child.innerValue)
        XCTAssertEqual(referenceCopyA.pointee.child.innerValue,
                       referenceCopyB.pointee.child.innerValue)
        
        XCTAssertEqual(withUnsafePointer(to: reference.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.child, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.child, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.child, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.child, {$0}))
        XCTAssertEqual(withUnsafePointer(to: reference.pointee.child.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyA.pointee.child.innerValue, {$0}))
        XCTAssertEqual(withUnsafePointer(to: referenceCopyA.pointee.child.innerValue, {$0}),
                       withUnsafePointer(to: referenceCopyB.pointee.child.innerValue, {$0}))
    }
    
    
    func testOnPointerDidChange() {
        var changeWitness = 0
        
        func updateWitness(oldValue: PassByValue, newValue: PassByValue) {
            XCTAssertEqual(oldValue.innerValue, changeWitness)
            changeWitness += 1
            XCTAssertEqual(newValue.innerValue, changeWitness)
        }
        
        let value = PassByValue(innerValue: 0)
        let reference = MutableSafePointer(to: value, onPointeeDidChange: updateWitness)
        let referenceCopyA = reference
        let referenceCopyB = reference
        
        XCTAssertEqual(changeWitness, 0)
        
        reference.pointee.innerValue += 1
        
        XCTAssertEqual(changeWitness, 1)
        
        referenceCopyA.pointee.innerValue += 1
        
        XCTAssertEqual(changeWitness, 2)
        
        referenceCopyB.pointee.innerValue += 1
        
        XCTAssertEqual(changeWitness, 3)
    }
    
    
    func testMultipleOnPointerDidChange() {
        var changeWitnessA = 0
        var changeWitnessB = 0
        
        
        func updateWitnessA(oldValue: PassByValue, newValue: PassByValue) {
            XCTAssertEqual(oldValue.innerValue, changeWitnessA)
            changeWitnessA += 1
            XCTAssertEqual(newValue.innerValue, changeWitnessA)
        }
        
        
        func updateWitnessB(oldValue: PassByValue, newValue: PassByValue) {
            XCTAssertEqual(oldValue.innerValue, changeWitnessB)
            changeWitnessB += 1
            XCTAssertEqual(newValue.innerValue, changeWitnessB)
        }
        
        
        let value = PassByValue(innerValue: 0)
        var updateWitnessAIdentifier = ObserverIdentifier()
        let reference = ObservableMutableSafePointer(to: value, newObserverIdentifier: &updateWitnessAIdentifier, onPointeeDidChange: updateWitnessA)
        let updateWitnessBIdentifier = reference.addObserver(updateWitnessB)
        let referenceCopyA = reference
        let referenceCopyB = reference
        
        XCTAssertEqual(changeWitnessA, 0)
        XCTAssertEqual(changeWitnessB, 0)
        
        reference.pointee.innerValue += 1
        
        XCTAssertEqual(changeWitnessA, 1)
        XCTAssertEqual(changeWitnessB, 1)
        
        referenceCopyA.pointee.innerValue += 1
        
        XCTAssertEqual(changeWitnessA, 2)
        XCTAssertEqual(changeWitnessB, 2)
        
        referenceCopyB.pointee.innerValue += 1
        
        XCTAssertEqual(changeWitnessA, 3)
        XCTAssertEqual(changeWitnessB, 3)
        
        let removeResultRandom = reference.removeObserver(withId: .random(in: .min ... .max))
        XCTAssertEqual(removeResultRandom, .observerNotFound)
        
        XCTAssertEqual(changeWitnessA, 3)
        XCTAssertEqual(changeWitnessB, 3)
        
        let removeResultA = reference.removeObserver(withId: updateWitnessAIdentifier)
        XCTAssertEqual(removeResultA, .removedSuccessfully)
        
        reference.pointee.innerValue += 1
        
        XCTAssertEqual(changeWitnessA, 3)
        XCTAssertEqual(changeWitnessB, 4)
        
        let removeResultB = reference.removeObserver(withId: updateWitnessBIdentifier)
        XCTAssertEqual(removeResultB, .removedSuccessfully)
        
        reference.pointee.innerValue += 1
        
        XCTAssertEqual(changeWitnessA, 3)
        XCTAssertEqual(changeWitnessB, 4)
        
        let removeResultA2 = reference.removeObserver(withId: updateWitnessAIdentifier)
        XCTAssertEqual(removeResultA2, .observerNotFound)
        
        let removeResultB2 = reference.removeObserver(withId: updateWitnessBIdentifier)
        XCTAssertEqual(removeResultB2, .observerNotFound)
    }
    
    
    static var allTests = [
        ("testPassingStructByReference", testPassingStructByReference),
        ("testPassingNestedStructByReference", testPassingNestedStructByReference),
        ("testMutatingStructByReference", testMutatingStructByReference),
        ("testMutatingStructWithPropertyWrapper", testMutatingStructWithPropertyWrapper),
        ("testMutatingNestedStructByReference", testMutatingNestedStructByReference),
        ("testOnPointerDidChange", testOnPointerDidChange),
        ("testMultipleOnPointerDidChange", testMultipleOnPointerDidChange),
    ]
    
    
    
    struct PassByValue: Hashable {
        var innerValue: Int
    }
    
    
    
    struct PassByValueParent: Hashable {
        var child: Child
        
        typealias Child = PassByValue
    }
    
    
    struct HasMutableSafePointerAsPropertyWrapper {
        @MutableSafePointer
        var innerValue: Int
    }
}
