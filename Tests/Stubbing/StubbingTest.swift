//
//  StubbingTest.swift
//  Cuckoo
//
//  Created by Filip Dolnik on 04.07.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import XCTest
import Cuckoo

class StubbingTest: XCTestCase {
    
    func testMultipleReturns() {
        let mock = MockTestedClass()
        stub(mock) { mock in
            when(mock.readOnlyProperty.get).thenReturn("a").thenReturn("b", "c")
        }
        
        XCTAssertEqual(mock.readOnlyProperty, "a")
        XCTAssertEqual(mock.readOnlyProperty, "b")
        XCTAssertEqual(mock.readOnlyProperty, "c")
        XCTAssertEqual(mock.readOnlyProperty, "c")
    }
    
    func testOverrideStubWithMoreGeneralParameterMatcher() {
        let mock = MockTestedClass()
        stub(mock) { mock in
            when(mock.countCharacters("a")).thenReturn(2)
            when(mock.countCharacters(anyString())).thenReturn(1)
        }
        
        XCTAssertEqual(mock.countCharacters("a"), 1)
    }
    
    func testOverrideStubWithMoreSpecificParameterMatcher() {
        let mock = MockTestedClass()
        stub(mock) { mock in
            when(mock.countCharacters(anyString())).thenReturn(1)
            when(mock.countCharacters("a")).thenReturn(2)
        }
        
        XCTAssertEqual(mock.countCharacters("a"), 2)
    }
    
    func testUnstubbedSpy() {
        let mock = MockTestedClass().spy(on: TestedClass())
        
        XCTAssertEqual(mock.countCharacters("a"), 1)
    }
    
    func testStubOfMultipleDifferentCalls() {
        let mock = MockTestedClass()
        stub(mock) { mock in
            when(mock.readOnlyProperty.get).thenReturn("a")
            when(mock.countCharacters("a")).thenReturn(1)
        }
        
        XCTAssertEqual(mock.readOnlyProperty, "a")
        XCTAssertEqual(mock.countCharacters("a"), 1)
    }
}