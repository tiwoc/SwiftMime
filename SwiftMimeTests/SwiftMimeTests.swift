//
//  SwiftMimeTests.swift
//  SwiftMimeTests
//
//  Created by di wu on 2/9/15.
//  Copyright (c) 2015 di wu. All rights reserved.
//

import UIKit
import XCTest
import SwiftMime

class SwiftMimeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLookupType() {
        XCTAssertEqual(SwiftMime.sharedManager.lookupType("txt"), "text/plain")
    }

    func testLookupUnknownType() {
        XCTAssertNil(SwiftMime.sharedManager.lookupType("doesnotexist"))
    }
    
    func testLookupExtension() {
        XCTAssertEqual(SwiftMime.sharedManager.lookupExtension("application/atom+xml"), "atom")
    }

    func testLookupUnknownExtension() {
        XCTAssertNil(SwiftMime.sharedManager.lookupExtension("does-not/exist"))
    }

    func testDefine() {
        SwiftMime.sharedManager.define([
            "text/x-some-format": ["x-sf", "x-sft", "x-sfml"],
            "application/x-my-type": ["x-mt", "x-mtt"]
            ])
        XCTAssertEqual(SwiftMime.sharedManager.lookupExtension("application/x-my-type"), "x-mt")
        XCTAssertEqual(SwiftMime.sharedManager.lookupType("x-mtt"), "application/x-my-type")
    }
    
}
