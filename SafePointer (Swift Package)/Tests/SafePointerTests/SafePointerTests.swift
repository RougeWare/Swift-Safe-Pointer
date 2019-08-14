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
    
    
    static var allTests = [
        ("testPassingStructByReference", testPassingStructByReference),
        ("testPassingNestedStructByReference", testPassingNestedStructByReference),
        ("testMutatingStructByReference", testMutatingStructByReference),
        ("testMutatingNestedStructByReference", testMutatingNestedStructByReference),
        ("testOnPointerDidChange", testOnPointerDidChange),
    ]
    
    
    
    struct PassByValue: Hashable {
        var innerValue: Int
    }
    
    
    
    struct PassByValueParent: Hashable {
        var child: Child
        
        typealias Child = PassByValue
    }
}
